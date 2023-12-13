parseSequence :: String -> [Int]
parseSequence = map read . words

predictNext :: [Int] -> Int
predictNext numbers
    | all (== 0) numbers = 0
    | otherwise = let
        adjacentDifferences = zipWith (-) (tail numbers) numbers
        in last numbers + predictNext adjacentDifferences

predictPrev :: [Int] -> Int
predictPrev = predictNext . reverse

getPredictionSums :: [[Int]] -> (Int, Int)
getPredictionSums sequences = let
    sumPredictions = sum . flip map sequences
    in (sumPredictions predictPrev, sumPredictions predictNext)

main = getPredictionSums . map parseSequence . lines <$> getContents >>= print
