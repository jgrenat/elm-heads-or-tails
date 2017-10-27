module Tests exposing (..)

import Main exposing (CoinState(Heads, Tails), GameState(Loss, Win), Model(..), Msg(CoinFlipped, FlipCoin, PlayerBet), randomCoin, update, view)
import Test exposing (..)
import Test.Html.Query as Query
import Expect
import Random
import Test.Html.Selector exposing (text)


modelGameHead : Model
modelGameHead =
    Game Heads


all : Test
all =
    describe "Heads or Tails"
        [ test "Guessing the correct answer should make the player win" <|
            \_ ->
                Expect.equal (update (PlayerBet Heads) modelGameHead) ( Result Win, Cmd.none )
        , test "Guessing the wrong answer should make the player lose" <|
            \_ ->
                Expect.equal (update (PlayerBet Tails) modelGameHead) ( Result Loss, Cmd.none )
        , test "Having winned a game should display a congratulation message" <|
            \_ ->
                view (Result Win) |> Query.fromHtml |> Query.has [ text "Congrats, you were right!" ]
        , test "Having lost a game should display a message full of disappointment" <|
            \_ ->
                view (Result Loss) |> Query.fromHtml |> Query.has [ text "You failed..." ]
        ]
