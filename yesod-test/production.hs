import Controller (withTest)
import Network.Wai.Handler.Warp (run)

main :: IO ()
main = withTest $ run 3000
