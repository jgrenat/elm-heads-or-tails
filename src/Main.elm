module Main exposing (Model(..), Msg(..), init, main, startGameButton, update, view)

import Html exposing (Html, button, div, p, text)
import Browser exposing (element)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Random


main : Program () Model Msg
main =
    element { init = always init, view = view, update = update, subscriptions = \m -> Sub.none }


type Model
    = NoGame
    | Game CoinState
    | Result GameState


type Msg
    = FlipCoin
    | CoinFlipped CoinState
    | PlayerBet CoinState


type GameState
    = Win
    | Loss


type CoinState
    = Head
    | Tail


init : ( Model, Cmd Msg )
init =
    ( NoGame, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FlipCoin ->
            ( NoGame, Random.generate CoinFlipped randomCoin )

        CoinFlipped coinState ->
            ( Game coinState, Cmd.none )

        PlayerBet coinState ->
            let
                result =
                    if Game coinState == model then
                        Win
                    else
                        Loss
            in
                ( Result result, Cmd.none )


randomCoin : Random.Generator CoinState
randomCoin =
    Random.uniform Head [ Tail ]


view : Model -> Html Msg
view model =
    case model of
        NoGame ->
            div []
                [ startGameButton ]

        Game coinState ->
            div []
                [ p [] [ text "Heads or Tails?" ]
                , button [ class "btn btn-default", onClick (PlayerBet Head) ] [ text "Heads" ]
                , button [ class "btn btn-default", onClick (PlayerBet Tail) ] [ text "Tails" ]
                ]

        Result state ->
            let
                result =
                    if state == Win then
                        "Congrats, you were right!"
                    else
                        "You failed..."
            in
                div []
                    [ p [] [ text result ]
                    , startGameButton
                    ]


startGameButton : Html Msg
startGameButton =
    button [ class "btn btn-primary", onClick FlipCoin ] [ text "Start a new game" ]
