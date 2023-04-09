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
            { from = "./dotfiles/configs/shell/.bash_profile", to = "~/" }
        },
        post_jobs = {
            "chsh -s /bin/zsh",
        },
        deps = {
            ["pkgfile"] = {
                post_jobs = {
                    "sudo pkgfile -u"
                }
            }
        }
    },
    ["xclip"] = { },
    ["i3-wm"] = {
        copy = {
            { from = "./dotfiles/configs/i3/", to = "~/.config/" },
        },
        deps = {
            ["python-i3ipc"] = {
                copy = {
                    { as_root = true, from = "./dotfiles/local-binaries/i3-resize-tool", to = "~/.local/bin/" },
                    { as_root = true, from = "./dotfiles/local-binaries/i3-window-tool", to = "~/.local/bin/" },
                },
                post_jobs = {
                    "chmod +x ~/.local/bin/i3-resize-tool",
                    "chmod +x ~/.local/bin/i3-window-tool"
                }
            },
            ["xdotool"] = {
                copy = {
                    { as_root = true, from = "./dotfiles/local-binaries/scratchcat", to = "~/.local/bin/" }
                },
                post_jobs = {
                    "chmod +x ~/.local/bin/scratchcat"
                }
            },
            ["alacritty"] = {
                copy = {
                    { from = "./dotfiles/configs/alacritty/", to = "~/.config/" }
                },
                deps = {
                    ["ttf-firacode-nerd"] = { },
                    ["ttf-fira-code"] = { },
                    ["ttf-nerd-fonts-symbols-common"] = {
                        copy = {
                            { from = "./dotfiles/configs/fontconfig/", to = "~/.config/" }
                        }
                    }
                }
            },
            ["rofi"] = {
                copy = {
                    { from = "./dotfiles/configs/rofi/", to = "~/.config/" }
                }
            },
            ["i3lock"] = {
                deps = {
                    ["xss-lock"] = { }
                }
            },
            ["feh"] = {
                copy = {
                    { from = "./dotfiles/assets/wallpapers/flower-dark.jpg", to = "~/Pictures/Wallpapers/" }
                }
            },
            ["flameshot"] = { },
            ["flashfocus-git"] = { },
            ["xrandr"] = { },
            ["picom"] = {
                copy = {
                    { from = "./dotfiles/configs/picom/", to = "~/.config/" }
                },
                deps = {
                    ["xorg-xwininfo"] = { }
                }
            },
            ["dunst"] = {
                copy = {
                    { from = "./dotfiles/configs/dunst/", to = "~/.config/" }
                }
            },
            ["polybar"] = {
                copy = {
                    { from = "./dotfiles/configs/polybar/", to = "~/.config/" },
                    { as_root = true, from = "./dotfiles/local-binaries/launch-polybar", to = "~/.local/bin/" }
                },
                post_jobs = {
                    "chmod +x ~/.local/bin/launch-polybar"
                },
                deps = {
                    ["xbacklight"] = { },
                    ["pavucontrol"] = { },
                    ["cozette-ttf"] = { }
                }
            },
            ["ncpamixer"] = { },
            ["htop"] = { },
            ["calc"] = { },
            ["calcurse"] = { },
            ["ranger"] = {
                copy = {
                    { from = "./dotfiles/configs/ranger/", to = "~/.config/" }
                }
            }
        }
    }
}

return manifest
