module Main where

import qualified Data.ByteString           as B
import qualified Data.ByteString.Char8     as CB
import           Data.Default
import           Network.Socket
import qualified Network.Socket.ByteString as SB
import           System.IO


main :: IO ()
main = do
    sock <- socket AF_INET Stream 0
    setSocketOption sock ReuseAddr 1
    bind sock (SockAddrInet 3456 iNADDR_ANY)
    listen sock 1
    mainLoop sock


mainLoop :: Socket -> IO ()
mainLoop sock = do
    (con, _) <- accept sock
    runCon con
    mainLoop sock


runCon :: Socket -> IO ()
runCon sock = do
    hdl <- socketToHandle sock ReadWriteMode
    hSetBuffering hdl NoBuffering
    hPutStrLn hdl "Hello!"
    hClose hdl
