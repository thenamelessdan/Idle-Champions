class IC_UserStatHandler_Class extends SH_StaticMemoryPointer
{
    GetVersion()
    {
        return "v0.0.3, 2025-08-11"
    }

    Refresh()
    {        
        if (_MemoryManager.is64bit == "") ; Don't build offsets if no client is available to check variable types.
            return
        baseAddress := _MemoryManager.baseAddress["mono-2.0-bdwgc.dll"]+this.ModuleOffset
        if (this.BasePtr.BaseAddress != baseAddress)
        {
            this.BasePtr.BaseAddress := baseAddress
            this.Is64Bit := _MemoryManager.is64bit
            if (this.CrusadersGame == "")
            {
                this.CrusadersGame := {}
                this.CrusadersGame.User := {}
                this.CrusadersGame.User.UserStatHandler := new GameObjectStructure(this.StructureOffsets)
                this.CrusadersGame.User.UserStatHandler.BasePtr := new SH_BasePtr(this.BasePtr.BaseAddress, this.ModuleOffset, this.StructureOffsets)
                this.CrusadersGame.User.UserStatHandler.Is64Bit := _MemoryManager.is64Bit
                #include *i %A_LineFile%\..\Imports\IC_UserStatHandler64_Import.ahk
                return
            }
            this.CrusadersGame.User.UserStatHandler.BasePtr := new SH_BasePtr(this.BasePtr.BaseAddress, this.ModuleOffset, this.StructureOffsets, "UserStatHandler")
            this.ResetBasePtr(this.CrusadersGame.User.UserStatHandler)
        }
    }
}