local manifest = require "manifest"

FormatHome = function(path)
    return path:gsub("~/", manifest.user_home)
end

FormatCopyCommand = function(copy_job)
    local sudo = copy_job.as_root ~= nil and copy_job.as_root == true and "sudo " or ""
    return sudo .. "mkdir -p " .. copy_job.to .. " && " .. sudo .. "cp -a " .. copy_job.from .. " " .. FormatHome(copy_job.to)
end

ResolveDependency = function(name, package)
    print("")
    print("     > Resolving Dependency \"" .. name .. "\"")

    print("")
    print("     > Installing Package")
    print("")
    os.execute("yay --noconfirm -S " .. name)

    if package.copy ~= nil then

        print("")
        for _, copy_job in ipairs(package.copy) do

            print("     > Copying From: " .. copy_job.from)
            print("               To:   " .. copy_job.to)
            print("")

            os.execute(FormatCopyCommand(copy_job))
        end
    end

    if package.post_jobs ~= nil then
        print("")
        for _, post_job in ipairs(package.post_jobs) do
            print("     > Package Post-Job \"" .. FormatHome(post_job) .. "\"")
            print("")
            os.execute(FormatHome(post_job))
        end
    end

    if package.deps ~= nil then
        for dep_name, dep_package_job in pairs(package.deps) do
            ResolveDependency(dep_name, dep_package_job)
        end
    end
end

for name, package_job in pairs(manifest.package_jobs) do
    ResolveDependency(name, package_job)
end

