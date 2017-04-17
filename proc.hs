-- stack runghc

import Control.Monad
import Data.List
import Data.Char
import qualified Data.Map as M

chunksOf :: (a -> Bool) -> [a] -> [[a]]
chunksOf pred list = go list
    where
        go [] = []
        go (x : xs) | not (pred x) = go xs
        go xs = case span pred xs of
            (c, rest) -> c : go rest

getOneGlyph :: [String] -> (Char, String)
getOneGlyph ([c] : font@(l1:_)) = (c, cfont)
    where cfont = unlines (map (++ "$@") font) ++ replicate (length l1) ' ' ++ "$@@\n"

getGlyphs :: String -> [[String]]
getGlyphs = chunksOf (not . null) . map init . lines

findGlyph :: M.Map Char String -> Char -> String
findGlyph m c = M.findWithDefault "@\n@\n@\n@\n@@\n" (toUpper c) m

requiredChars :: [Char]
requiredChars = [' ' .. '~'] ++ map chr [196, 214, 220, 228, 246, 252, 223]

main :: IO ()
main = do
    let loopHeader = do
            line <- getLine
            when (line /= "$") (putStrLn line >> loopHeader)
    loopHeader
    contents <- getContents
    if not $ all ((== '$') . last) (lines contents)
        then putStrLn "Not every data line ends with a dollar sign ('$')"
        else
            let glyphMap = M.fromList (map getOneGlyph . getGlyphs $ contents)
            in
                mapM_ (putStr . findGlyph glyphMap) requiredChars