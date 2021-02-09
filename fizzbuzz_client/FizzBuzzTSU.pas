unit FizzBuzzTSU;

// Unit that implementes the Transaction Script pattern similar to Context in Phoenix.
// Group together logic of the same domain

interface

uses
    CommandLineU;

type

    IFizzbuzzTransactionScript = interface
        ['{60B0DA79-2B23-45D6-9D3B-4605B50EF997}']
        function DoCommand(
            const aCommand:     TCommandLine;
            const aCommandLine: String): String;
        function Fizzbuzz(const aPage, aSize: Integer): String;
        function Favourites(
            const aNumber:   Integer;
            const Favourite: Boolean): String;
    end;

function CreateFizzbuzzTS: IFizzbuzzTransactionScript;

implementation

uses
    System.Classes,
    System.SysUtils,
    System.Generics.Collections,
    System.Net.URLClient,
    System.Net.HTTPClient,
    System.JSON,
    GpCommandLineParser;

type
    TFizzbuzzTS = class(TInterfacedObject, IFizzbuzzTransactionScript)
    private
        function DoRequest(
            const aURL:        String;
            const aRestMethod: String;
            const aPayload:    String;
            const aTimeout:    Integer = 5000): TPair<Integer, String>;

    public
        function DoCommand(
            const aCommand:     TCommandLine;
            const aCommandLine: String): String;
        function Fizzbuzz(const aPage, aSize: Integer): String;
        function Favourites(
            const aNumber:   Integer;
            const Favourite: Boolean): String;
    end;

{ TFizzbuzzTS }

function TFizzbuzzTS.DoCommand(
    const aCommand:     TCommandLine;
    const aCommandLine: String): String;
var
    parsed: Boolean;
begin
    parsed := CommandLineParser.Parse(aCommandLine, aCommand);
    if not parsed then
        raise Exception.Create('Error');
    if aCommand.Command.ToLower.Equals(FizzbuzzCommand) then
        Result := Fizzbuzz(aCommand.Page, aCommand.PageSize)
    else if aCommand.Command.ToLower.Equals(FavouritesCommand) then
        Result := Favourites(aCommand.Number, aCommand.Favourite > 0)
    else
        raise Exception.CreateFmt('Command %s not valid', [aCommand.Command]);
end;

function TFizzbuzzTS.DoRequest(
    const aURL:        String;
    const aRestMethod: String;
    const aPayload:    String;
    const aTimeout:    Integer): TPair<Integer, String>;

var
    lCLient:   THTTPClient;
    lStream:   TStream;
    lResponse: IHTTPResponse;
    lRequest:  IHTTPRequest;
begin
    lCLient := THTTPClient.Create;
    lStream := nil;
    try
        lCLient.ConnectionTimeout := aTimeout;
        lCLient.ResponseTimeout := aTimeout;

        lStream := TStringStream.Create(aPayload);
        lRequest := lCLient.GetRequest(aRestMethod, aURL);
        lRequest.SourceStream := lStream;
        lRequest.AddHeader('Content-Type', 'application/json');
        lResponse := lCLient.Execute(lRequest);
        Result.Key := lResponse.StatusCode;
        Result.Value := lResponse.ContentAsString;
    finally
        lStream.Free;
        lCLient.Free;
    end;
end;

function TFizzbuzzTS.Favourites(
    const aNumber:   Integer;
    const Favourite: Boolean): String;
var
    lJObj: TJSONObject;
begin
    lJObj := TJSONObject.Create;
    try
        lJObj.AddPair('number', TJSONNumber.Create(aNumber));
        lJObj.AddPair('is_favourite', TJSONBool.Create(Favourite));
        Result := DoRequest('http://localhost:4000/api/favourites', 'PUT',
            lJObj.ToJSON).Value;
    finally
        lJObj.Free;
    end;
end;

function TFizzbuzzTS.Fizzbuzz(const aPage, aSize: Integer): String;
begin
    Result := DoRequest
        (Format('http://localhost:4000/api/fizzbuzz?page=%d&page_size=%d',
        [aPage, aSize]), 'GET', '').Value;
end;

function CreateFizzbuzzTS: IFizzbuzzTransactionScript;
begin
    Result := TFizzbuzzTS.Create;
end;

end.
