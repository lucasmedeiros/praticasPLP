calc :: Int -> Int -> IO()
calc n m = do
    if n > 0 then do
        entrada <- getLine
        calc (n-1) (m + valor entrada)
    else putStrLn(show(m))


valor :: String -> Int
valor n
    | n == "cafe" = 8
    | n == "almoco" = 12
    | n == "jantar" = 10
    | otherwise = 0

main :: IO()
main = do
    entrada <- getLine
    calc (read entrada) 0