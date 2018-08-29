module Main exposing (Model(..), Msg(..), init, main, startGameButton, update, view)

import Html exposing (Html, button, div, text)
import Browser exposing (element)
import Html.Attributes exposing (class)


main : Program () Model Msg
main =
    element { init = (\a -> init), view = view, update = update, subscriptions = \m -> Sub.none }


type Model
    = NoGame


type Msg
    = None


init : ( Model, Cmd Msg )
init =
    ( NoGame, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ startGameButton ]


startGameButton : Html Msg
startGameButton =
    button [ class "btn btn-primary" ] [ text "Start a new game" ]
