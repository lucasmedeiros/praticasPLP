elimina :: String -> String -> String
elimina l [] = []
elimina l (a:as) | l == [a] = elimina l as
                 | otherwise = [a] ++ (elimina l as)
main :: IO()
main = do
    l <- getLine
    pal <- getLine
    putStrLn(elimina l pal)