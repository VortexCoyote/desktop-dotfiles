local manifest = { }

manifest.user_home = "/home/x3tr0v/"

manifest.package_jobs = {
    ["ly"] = {
        copy = {
            { as_root = true, from = "./dotfiles/configs/ly/", to = "/etc/" }
        },
        post_jobs = {
            "sudo systemctl enable ly.service"
        }
    },
    ["oh-my-zsh-git"] = {
        copy = {
            { from = "./dotfiles/configs/shell/.zshrc", to = "~/" },
            { from = "./dotfiles/configs/shell/.bashrc", to = "~/" },
            { from = "./dotfiles/configs/shell/.bash_profile", to = "~/" },
            { from = "./dotfiles/configs/shell/oh-my-zsh/", to = "~/.config/" }
        },
        post_jobs = {
            "chsh -s /bin/zsh",
            "git clone https://github.com/zsh-users/zsh-autosuggestions ~/.config/oh-my-zsh/plugins/zsh-autosuggestions",
            "git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.config/oh-my-zsh/plugins/zsh-syntax-highlighting"
        },
        deps = {
            ["pkgfile"] = {
                post_jobs = {
                    "sudo pkgfile -u"
                }
            }
        }
    },
    ["hyprland"] = {
        copy = {
            { from = "./dotfiles/configs/hypr/", to = "~/.config/" },
        },
        deps = {
            ["xdg-desktop-portal-wlr"] = { },
            ["rofi-lbonn-wayland-git"] = {
                copy = {
                    { from = "./dotfiles/configs/rofi/", to = "~/.config/" }
                }
            },
            ["clipman"] = { },
            ["slurp"] = { },
            ["grim"] = { },
            ["swappy"] = {
                copy = {
                    { from = "./dotfiles/configs/swappy/", to = "~/.config/" }
                }
            },
            ["hyprpaper"] = {
                copy = {
                    { from = "./dotfiles/assets/wallpapers/flower-dark.jpg", to = "~/Pictures/Wallpapers/" }
                }
            },
            ["htop-vim"] = { },
            ["waybar-hyprland"] = {
                copy = {
                    { from= "./dotfiles/configs/waybar/", to = "~/.config/" }
                }
            }
        }
    }
}

return manifest
