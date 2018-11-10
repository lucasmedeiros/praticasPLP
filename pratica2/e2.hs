jogo :: Int -> IO()
jogo x = do
   y <- readLn
   if y > 10 then jogo (x)
   else if (x + y) > 21 then putStrLn "PERDEU!"
   else if (x + y) == 21 then putStrLn "VENCEU!"
   else jogo (x + y)

main :: IO()
main = do
   jogo 0