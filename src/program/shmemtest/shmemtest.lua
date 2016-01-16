-- run:
--  sudo ./snabb test program/example_replay/input.pcap  out.pcap

module(..., package.seeall)

--local tester = require("program.test.tester")
local ffi = require("ffi")

-- lib.ipc.shmem.mib is subclass of lib.ipc.shmem, thus inherts its methods, etc.
local ipc_mib = require("lib.ipc.shmem.mib")


function run (parameters)
 if not (#parameters == 0) then
  print("Usage: shmemtest <input> <output>")
  main.exit(1)
 end
 --local input = parameters[1]
 --local output = parameters[2]

 -- from
 --  https://github.com/hb9cwp/snabbswitch/blob/intel1g_rs_i210/src/lib/ipc/shmem/shmem.lua

 local mib = ipc_mib:attach({ filename = "pw", directory = "/tmp/snabb-shmem"})

 -- from ipc_mib:new() in
 --  https://github.com/hb9cwp/snabbswitch/blob/intel1g_rs_i210/src/program/l2vpn/pseudowire.lua
 mib:register('pwType', 'Integer32')
 mib:register('pwOwner', 'Integer32')
 mib:register('pwPerfTotalErrorPackets', 'Counter32', 10)

 print("pwType= ", mib:get('pwType'))	-- 5
 print("pwOwner= ", mib:get('pwOwner'))	-- 1
 print("pwPerfTotalErrorPackets= ", mib:get('pwPerfTotalErrorPackets'))	-- 10

end
