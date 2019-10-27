package.path = debug.getinfo(1,"S").source:match[[^@?(.*[\/])[^\/]-$]] .."?.lua;".. package.path

automationItemsProcessor = require('libs.automationItemsProcessor')

function main()
    reaper.Undo_BeginBlock()

    automationItemsProcessor.createAutomationItems({'Volume'})

    reaper.Undo_EndBlock('Setting new pooled automation items', -1)
end

reaper.defer(main)
