import qualified System.Process

inv_aux :: String -> String -> String
inv_aux [] rev_l = rev_l
inv_aux (h:t) rev_l = inv_aux t ([h]++rev_l)

inverte_lista :: String -> String -> String -> String
inverte_lista [] _ _ = []
inverte_lista (h:t) atual (x:xs)
    | (h == x) = atual++(x:xs)++(inv_aux t [])
    | otherwise = inverte_lista t (atual++[h]) (x:xs)

main :: IO()
main = do
    char <- getLine
    str <- getLine
    putStrLn (inverte_lista str [] char)