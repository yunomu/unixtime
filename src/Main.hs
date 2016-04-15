module Main where

import qualified Data.ByteString.Char8 as BC
import Data.UnixTime (UnixTime)
import qualified Data.UnixTime as UnixTime
import qualified Safe
import System.Environment (getArgs)

epoch :: UnixTime
epoch = UnixTime.UnixTime 0 0

exec :: String -> IO ()
exec str = UnixTime.formatUnixTime fmt time >>= BC.putStrLn
  where
    millis :: Integer
    millis = read str
    micros = millis * 1000
    diff = UnixTime.microSecondsToUnixDiffTime micros
    time = UnixTime.addUnixDiffTime epoch diff
    fmt = "%Y/%m/%d %H:%M:%S %z"

main :: IO ()
main = do
    args <- getArgs
    maybe (return ()) exec $ Safe.headMay args
