module Client where

import qualified Data.ByteString           as B
import qualified Data.ByteString.Char8     as CB
import           Data.Default
import           Network.Socket
import qualified Network.Socket.ByteString as SB
import           System.IO


mainTwo :: IO ()
mainTwo = do
    sock <- socket AF_INET Stream 0
    setSocketOption sock ReuseAddr 1
    connect sock (SockAddrInet 3456 (tupleToHostAddress (127, 0, 0, 1)))
    runCon sock


runCon :: Socket -> IO ()
runCon sock = do
    hdl <- socketToHandle sock ReadWriteMode
    msg <- hGetLine hdl
    putStrLn msg
