local manifest = require(arg[1])

FormatHome = function(path)
    return path:gsub("~/", manifest.user_home)
end

FormatCopyCommand = function(copy_job)
    local sudo = copy_job.as_root ~= nil and copy_job.as_root == true and "sudo " or ""
    if sudo ~= "" then
        print("               Requesting Root ...")
    end
    return sudo .. "mkdir -p " .. copy_job.to .. " && " .. sudo .. "cp -a " .. copy_job.from .. " " .. FormatHome(copy_job.to)
end

FormatUpdateDotfilesCommand = function(copy_job)
    return "cp -a " .. FormatHome(copy_job.copy_to) .. " " .. copy_job.copy_from
end

local install_commands = {
    priority = { "--install-packages", "--copy-dotfiles", "--run-post-jobs" },
    ["--install-packages"] = function(name, _)
        print("     > Resolving Dependency \"" .. name .. "\"")
        print("")
        print("     > Installing Package")
        print("")
        os.execute("yay --noconfirm -S " .. name)
    end,
    ["--copy-dotfiles"] = function(_, package)
        if package.copy ~= nil then
            for _, copy_job in ipairs(package.copy) do
                print("     > Copying From: " .. copy_job.from)
                print("               To:   " .. copy_job.to)
                os.execute(FormatCopyCommand(copy_job))
                print("")
            end
        end
    end,
    ["--run-post-jobs"] = function(_, package)
        if package.post_jobs ~= nil then
            for _, post_job in ipairs(package.post_jobs) do
                print("     > Package Post-Job \"" .. FormatHome(post_job) .. "\"")
                print("")
                os.execute(FormatHome(post_job))
            end
        end
    end
}

ResolvePackage = function(name, package, install_args)
    for _, command_type in ipairs(install_args) do
        install_commands[command_type](name, package)
    end
    if package.deps ~= nil then
        for dep_name, dep_package_job in pairs(package.deps) do
            ResolvePackage(dep_name, dep_package_job, install_args)
        end
    end
end

-- main routine
local commands_to_run = nil

if arg[2] == nil then
    commands_to_run = install_commands.priority or { }
else
    for _, command_type in ipairs(install_commands.priority) do
        for _, arg_value in ipairs(arg) do
            if arg_value == command_type then
                if commands_to_run == nil then commands_to_run = { } end
                table.insert(commands_to_run, command_type)
            end
        end
    end
end

if commands_to_run == nil then
    print("bad arguments, doing nothing :(")
else
    for name, package_job in pairs(manifest.package_jobs) do
        ResolvePackage(name, package_job, commands_to_run)
    end
end

