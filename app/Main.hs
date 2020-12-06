{-# LANGUAGE OverloadedStrings #-}

module Main where

import qualified Network.Wai.Handler.Warp as Warp
import Web.Scotty (get, scottyApp, text)

main :: IO ()
main = do
  let settings = Warp.setPort 3000 Warp.defaultSettings
  app <- scottyApp $ get "/" $ text ""
  Warp.runSettings settings app
