import System.Environment(getArgs)

parseInteger :: String -> Either String Integer
parseInteger str =
  case reads str of
  [(x, "")] -> Right x
  _         -> Left "Invalid Integer"

fib :: Integer -> Integer
  fib x
    | x == 1 = 1
    | x == 2 = 2
    | otherwise = last $ take (fromIntegral x) [fib' n | n <- [1..] ]
    
    where
      fib' 1 = 1
      fib' 2 = 2
      fib' n = fib (n - 1) + fib (n - 2)

main :: IO()
main = do
  args <- getArgs
  case args of
    [x] -> case parseInteger x of
      Right n -> putStrLn $ show (fib n)
      Left err -> putStrLn $ "Error: " ++ err
    _ -> putStrLn "Usage: fibonacci <number>"
