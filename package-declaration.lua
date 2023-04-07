local home = "/home/x3tr0v/"

local packages = {}

packages["i3-wm"] = {
    conf = {
        from = "./dotfiles/configs/i3",
        to = "~/.config/"
    },
    resources = {
        ["i3-resize-tool"] = {
            make_runnable = true,
            from = "./dotfiles/local-binaries/i3-resize-tool",
            to = "~/.local/bin/"
        },
        ["i3-window-tool"] = {
            make_runnable = true,
            from = "./dotfiles/local-binaries/i3-window-tool",
            to = "~/.local/bin/"
        }
    },
    deps = {
        ["alacritty"] = {
            conf = {
                from = "./dotfiles/configs/alacritty/",
                to = "~/.config/"
            },
            deps = {
                ["ttf-firacode-nerd"] = {},
                ["ttf-fira-code"] = {},
                ["oh-my-zsh-git"] = {
                    conf = {
                        from = "./dotfiles/configs/shell/.zshrc",
                        to = "~/"
                    }
                }
            }
        },
        ["rofi"] = {
            conf = {
                from = "./dotfiles/configs/rofi/",
                to = "~/.config/"
            }
        },
        ["i3lock"] = {
            deps = {
                ["xss-lock"] = {}
            }
        },
        ["feh"] = {
            resources = {
                ["wallpapers"] = {
                    from = "./dotfiles/assets/wallpapers/flower-dark.jpg",
                    to = "~/Pictures/Wallpapers/",
                }
            }
        },
        ["flameshot"] = {},
        ["flashfocus-git"] = {},
        ["xrandr"] = {},
        ["picom"] = {
            conf = {
                from = "./dotfiles/configs/picom/",
                to = "~/.config/"
            }
        },
        ["dunst"] = {
            conf = {
                from = "./dotfiles/configs/dunst/",
                to = "~/.config/"
            }
        },
        ["polybar"] = {
            conf = {
                from = "./dotfiles/configs/polybar/",
                to = "~/.config/"
            },
            deps = {
                ["xbacklight"] = {},
                ["pavucontrol"] = {}
            }
        },
        ["ncpamixer"] = {},
        ["htop"] = {},
        ["calc"] = {},
        ["calcurse"] = {}
    },
}


ResolveDependency = function(name, content)
    print("!!! RESOLVING DEP \"" .. name .. "\" !!!")

    print("!!! INSTALLING PACKAGE !!!")
    os.execute("yay --noconfirm -S " .. name)

    if content.conf ~= nil then
        print("!!! COPYING CONFIGS !!!")
        os.execute("mkdir " .. content.conf.to:gsub("~/", home))
        os.execute("cp -i -a " .. content.conf.from .. " " .. content.conf.to:gsub("~/", home))
    end

    if content.resources ~= nil then
        print("!!! COPYING RESOURCES!!!")
        for _, resource in pairs(content.resources) do
            os.execute("mkdir " .. resource.to:gsub("~/", home))
            os.execute("cp -a " .. resource.from .. " " .. resource.to:gsub("~/", home))
        end
    end

    if content.deps ~= nil then
        for dep_name, dep_content in pairs(content.deps) do
            ResolveDependency(dep_name, dep_content)
        end
    end
end

for name, content in pairs(packages) do
    ResolveDependency(name, content)
end
