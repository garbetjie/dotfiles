{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "geoff";
  home.homeDirectory = "/Users/geoff";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  home.packages = with pkgs; [
    awscli2
    axel
    bat
    coreutils
    direnv
    dive
    exiftool
    ffmpeg
    git-lfs
    gnugrep
    gnused
    gnutar
    htop
    inetutils
    jq
    mysql-client
    mtr
    optipng
#    nodejs-16_x
    p7zip
    shellcheck
    socat
    sqlite
    starship
    terraform
    tmux
    tree
    wget
    youtube-dl
    yq
  ];

  home.file = with config.lib.file; {
    dive = {
        source = mkOutOfStoreSymlink ./dive.yaml;
        target = ".dive.yaml";
    };
    config-nixpkgs-home = {
        source = mkOutOfStoreSymlink ./home.nix;
        target = ".config/nixpkgs/home.nix";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

	programs.dircolors = {
		enable = true;
		enableZshIntegration = true;
	};

	programs.direnv = {
		enable = true;
		enableZshIntegration = true;
		nix-direnv = {
			enable = true;
		};
	};

	programs.git = {
		enable = true;
		aliases = {
			st = "status";
			lg = "log --graph --pretty='%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)%an%Creset %C(blue)<%ae>%Creset' --abbrev-commit";
			search-history = "!f() { git log --pretty=format:'* %C(yellow)%h%Creset -%C(red)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%cn>%Creset' --decorate --date=relative -S$1; }; f";
			search-history-msg = "!f() { git log --pretty=format:'* %C(yellow)%h%Creset -%C(red)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%cn>%Creset' --decorate --date=relative --grep=$1; }; f";
		};
		diff-so-fancy = {
			enable = true;
		};
		lfs = {
			enable = true;
		};
		ignores = [
			"*~"
      ".DS_Store"
      ".idea/"
		];
		userName = "Geoff Garbers";
		includes = [
			{
				condition = "gitdir:~/Workspace/";
				path = "~/Workspace/.gitconfig";
			}
			{
				condition = "gitdir:~/Workspace/Unifii/";
				path = "~/Workspace/Unifii/.gitconfig";
			}
			{
				condition = "gitdir:~/Workspace/garbetjie/";
				path = "~/Workspace/garbetjie/.gitconfig";
			}
		];
		extraConfig = {
			push = {
				default = "simple";
			};
			core = {
				autocrlf = "input";
				excludesfile = "~/.gitignore";
			};
			merge = {
				renamelimit = 5000;
			};
			diff = {
				renamelimit = 5000;
			};
			color = {
				ui = true;
				diff = {
					meta = "yellow bold";
					commit = "cyan bold";
					frag = "magenta bold";
					old = "red bold";
					new = "green bold";
					whitespace = "red reverse";
				};
				diff-highlight = {
					oldNormal = "red bold";
					oldHighlight = "red bold 52";
					newNormal = "green bold";
					newHighlight = "green bold 22";
				};
				branch = {
					current = "yellow reverse";
					local = "yellow";
					remote = "green";
				};
				status = {
					added = "green";
					changed = "yellow";
					untracked = "red";
				};
			};
			pull = {
				rebase = true;
			};
			init = {
				defaultBranch = "main";
			};
		};
	};

	programs.htop = {
		enable = true;
		settings = {
			delay = 10;
		};
	};

	programs.ssh = {
		enable = true;
		compression = true;
		forwardAgent = true;
		serverAliveInterval = 30;
	};

	programs.starship = {
		enable = true;
		enableZshIntegration = true;
		settings = {
			cmd_duration = {
				show_milliseconds = true;
			};
			conda.disabled = true;
			crystal.disabled = true;
			daml.disabled = true;
			dart.disabled = true;
			deno.disabled = true;
			directory = {
				truncation_length = 7;
				truncation_symbol = ".../";
				truncate_to_repo = false;
				substitutions = {
					"/Users/geoff" = "~";
					"/Users/geoffrey.garbers" = "~";
				};
			};
			docker_context.disabled = true;
			dotnet = {
				disabled = false;
			};
			elixir.disabled = true;
			elm.disabled = true;
			env_var.disabled = true;
			erlang.disabled = true;
			haskell.disabled = true;
			helm.disabled = true;
			hostname.disabled = true;
			java.disabled = true;
			julia.disabled = true;
			kotlin.disabled = true;
			lua.disabled = true;
			nim.disabled = true;
			nix_shell = {
				disabled = false;
			};
			ocaml.disabled = true;
			openstack.disabled = true;
			package = {
				disabled = false;
			};
			perl.disabled = true;
			pulumi.disabled = true;
			purescript.disabled = true;
			raku.disabled = true;
			red.disabled = true;
			rlang.disabled = true;
			rust.disabled = true;
			scala.disabled = true;
			shell = {
				disabled = true;
			};
			shlvl = {
				disabled = false;
			};
			singularity.disabled = true;
			spack.disabled = true;
			status.disabled = false;
			sudo.disabled = false;
			swift.disabled = true;
			terraform = {
				format = "[$symbol$workspace]($style) ";
			};
			time.disabled = true;
			username.disabled = true;
			vagrant.disabled = true;
			vlang.disabled = true;
			vcsh.disabled = true;
			zig.disabled = true;
		};
	};

	programs.vim = {
		enable = true;
		settings = {
			expandtab = false;
			mousefocus = false;
			tabstop = 2;
		};
	};

	programs.zsh = {
		enable = true;
		enableAutosuggestions = true;
		enableSyntaxHighlighting = true;
		autocd = true;
		dirHashes = {
			w = "~/Workspace";
		};
		history = {
			ignoreDups = true;
			ignoreSpace = false;
		};
		shellAliases = {
			".." = "cd ..";
			"..." = "cd ../..";
			cat = "bat -P";
			sail = "./vendor/bin/sail";
			less = "bat";
			ll = "ls -lahG";
		};
	};

	targets.darwin.defaults = {
		com.apple.Finder = {
			FXPreferredViewStyle = "clmv";
			_FXSortFoldersFirst = true;
			FXDefaultSearchScope = "SCcf";
		};
		com.apple.dock = {
			tilesize = 33;
			magnification = true;
			largesize = 60;
			minimize-to-application = true;
			autohide = true;
			show-recents = false;
		};
		com.apple.menuextra.clock = {
			DateFormat = "EEE MMM d  H:mm:ss";
			IsAnalog = false;
		};
		com.apple.menuextra.battery = {
			ShowPercent = "YES";
		};
		com.apple.swipescrolldirection = false;
	};
}