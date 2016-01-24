module(..., package.seeall)
local ffi = require("ffi")
local header = require("lib.protocol.header")
local lib = require("core.lib")
local ntohl, htonl = lib.ntohl, lib.htonl
local ntohll, htonll = lib.ntohll, lib.htonll

local esp = subClass(header)

-- Class variables
esp._name = "esp"
esp:init(
   {
      -- implements AAD size 12 only
      [1] = ffi.typeof[[
            struct {
               uint32_t spi;
               uint64_t seq_no;
            } __attribute__((packed))
      ]]
   })

-- Class methods

function esp:new (config)
   local o = esp:superClass().new(self)
   o:spi(config.spi)
   o:seq_no(config.seq_no)
   return o
end

-- Instance methods

function esp:spi (spi)
   local h = self:header()
   if spi ~= nil then
      h.spi = htonl(spi)
   else
      return(ntohl(h.spi))
   end
end

function esp:seq_no (seq_no)
   local h = self:header()
   if seq_no ~= nil then
      h.seq_no = htonll(seq_no)
   else
      return(ntohll(h.seq_no))
   end
end

return esp
