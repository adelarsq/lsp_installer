local configs = require 'nvim_lsp/configs'
local util = require 'nvim_lsp/util'
local server_name = 'fsharp'
local bin_name = 'run'

local function make_installer()
  local install_dir = util.path.join{util.base_install_dir, server_name}

  local extracted_dir = "linux"

  if vim.fn.has('win32') == 1 then
    bin_name = 'fsautocomplete.exe'
  elseif vim.fn.has('mac') == 1 then
    extracted_dir = ''
  end

  local download_target = util.path.join{install_dir, "fsautocomplete.zip"}
  local extract_cmd = string.format("unzip '%s' -d '%s'", download_target, install_dir)
  local download_cmd = string.format('curl -fLo "%s" --create-dirs "https://github.com/fsharp/FsAutoComplete/releases/latest/download/fsautocomplete.zip"', download_target)

  local bin_path = util.path.join{install_dir, extracted_dir, bin_name}
  local X = {}
  function X.install()
    local install_info = X.info()
    if install_info.is_installed then
      print(server_name, "is already installed")
      return
    end
    if not (util.has_bins("curl")) then
      error('Need "curl" to install this.')
      return
    end
    vim.fn.mkdir(install_dir, 'p')
    vim.fn.system(download_cmd)
    vim.fn.system(extract_cmd)
  end
  function X.info()
    return {
      is_installed = util.path.exists(bin_path);
      install_dir = install_dir;
      cmd = { bin_path };
    }
  end
  function X.configure(config)
    local install_info = X.info()
    if install_info.is_installed then
      config.cmd = install_info.cmd
    end
  end
  return X
end

local installer = make_installer()

configs[server_name] = {
  default_config = {
    -- cmd = {"dotnet", "/Users/adelar/dev/FsAutoComplete/bin/release_netcore/fsautocomplete.dll", "--background-service-enabled", "--verbose"};
    cmd = {"dotnet", "/Users/adelar/dev/fsharp-language-server/src/FSharpLanguageServer/bin/Release/netcoreapp3.0/osx-x64/publish/FSharpLanguageServer.dll"};
    filetypes = {'fsharp'};
    root_dir = util.root_pattern("*.sln","*.fsproj");
    message_level = vim.lsp.protocol.MessageType.Log;
    init_options = {
    };
  };
  -- on_new_config = function(new_config) end;
  -- on_attach = function(client, bufnr) end;
  docs = {
    description = [[
https://github.com/fsharp/FsAutoComplete
F# language server using Language Server Protocol 
]];
    default_config = {
      root_dir = [[root_pattern("*.sln")]];
    };
  };
}

configs[server_name].install = installer.install
configs[server_name].install_info = installer.info

-- vim:et ts=2 sw=2
