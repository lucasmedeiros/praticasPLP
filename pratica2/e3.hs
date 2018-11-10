isPrime :: Int -> Bool
isPrime 1 = False
isPrime n = isPrimeAux n (n - 1)

isPrimeAux :: Int -> Int -> Bool
isPrimeAux _ 1 = True
isPrimeAux n i = (mod n i /= 0) && isPrimeAux n (i - 1)

decomporFrente :: String -> Int -> Int
decomporFrente str qtd = read [(str !! (qtd - 1))] :: Int
decomporTras str qtd = read (drop qtd str) :: Int

somaAlgarismos :: String -> Int -> Int
somaAlgarismos str 1 = (if isPrime (decomporFrente str 1) then 1 else 0)
somaAlgarismos str i = (if isPrime (decomporFrente str i) then 1 else 0) + somaAlgarismos str (i - 1)

somaTras :: String -> Int -> Int
somaTras str (-1) = 0
somaTras str 0 = (if isPrime (decomporTras str 1) then 1 else 0)
somaTras str 1 = (if isPrime (decomporTras str 1) then 1 else 0)
somaTras str i = (if isPrime (decomporTras str i) then 1 else 0) + somaTras str (i - 1)

qtdPrimos :: String -> Int
qtdPrimos str = if (str == "1") then 0 else (somaAlgarismos str (length str) + somaTras str ((length str) - 2))

main = do
   line <- getLine
   print (qtdPrimos line)