{ config, pkgs, ... }:
{
  enable = true;
  history.size = 10000;
  history.path = "${config.xdg.dataHome}/zsh/history";
  shellAliases = {
    vim = "nvim";
  };
  initExtra = ''
    [[ ! -f ${./p10k.zsh} ]] || source ${./p10k.zsh}
  '';
  oh-my-zsh = {
    enable = true;
    plugins = [
       "git"
    ];
  };
  plugins = [
    {
      # will source zsh-autosuggestions.plugin.zsh
	    name = "zsh-autosuggestions";
	    src = pkgs.zsh-autosuggestions;
    }
    {
	    name = "zsh-autocomplete";
	    src = pkgs.zsh-autosuggestions;
    }
    {
	    name = "zsh-syntax-highlighting";
	    src = pkgs.zsh-syntax-highlighting;
    }
    {
	    name = "enhancd";
	    file = "init.sh";
	    src = pkgs.fetchFromGitHub {
		    owner = "b4b4r07";
		    repo = "enhancd";
		    rev = "v2.2.1";
		    sha256 = "0iqa9j09fwm6nj5rpip87x3hnvbbz9w9ajgm6wkrd5fls8fn8i5g";
	    };
    }
    {
      name = "powerlevel10k";
      src = pkgs.zsh-powerlevel10k;
      file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    }
  ];
}
