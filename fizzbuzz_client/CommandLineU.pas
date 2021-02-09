unit CommandLineU;

interface

uses
    GpCommandLineParser;

const
    FizzbuzzCommand = 'fizzbuzz';
    FavouritesCommand = 'favourites';
    ValidCommands: TArray<String> = [FizzbuzzCommand, FavouritesCommand];

type

    TCommandLine = class(TObject)
    private
        FCommand:   String;
        FPageSize:  Integer;
        FPage:      Integer;
        FNumber:    Integer;
        FFavourite: Integer;
        procedure SetCommand(const Value: String);
        procedure SetPage(const Value: Integer);
        procedure SetPageSize(const Value: Integer);
        procedure SetNumber(const Value: Integer);
        procedure SetFavourite(const Value: Integer);
    public
        [CLPName('c'), CLPLongName('Command'),
            CLPDescription('API to call, can be "fizzbuzz" or "favourites"'),
            CLPRequired]
        property Command: String read FCommand write SetCommand;
        [CLPName('p'), CLPLongName('Page'),
            CLPDescription
            ('Page number in a pagination context. Valid only for "fizbuzz" command')
            ]
        property Page: Integer read FPage write SetPage;
        [CLPName('s'), CLPLongName('PageSize'),
            CLPDescription
            ('How many elements the API has to return per page. Valid only for "fizzbuzz" command')
            ]
        property PageSize: Integer read FPageSize write SetPageSize;
        [CLPName('n'), CLPLongName('Number'),
            CLPDescription
            ('A number you want to mark as favourite. Valid only for "favourites" command')
            ]
        property Number: Integer read FNumber write SetNumber;
        [CLPName('f'), CLPLongName('Favourite'),
            CLPDescription
            ('An integer 1 or 0 to mark the number as favourite. Valid only for "favourites" command')
            ]
        property Favourite: Integer read FFavourite write SetFavourite;

    end;

implementation

uses
    System.StrUtils,
    System.SysUtils;

{ TCommandLine }

procedure TCommandLine.SetCommand(const Value: String);
begin
    FCommand := Value;
end;

procedure TCommandLine.SetFavourite(const Value: Integer);
begin
    FFavourite := Value;
end;

procedure TCommandLine.SetNumber(const Value: Integer);
begin
    FNumber := Value;
end;

procedure TCommandLine.SetPage(const Value: Integer);
begin
    FPage := Value;
end;

procedure TCommandLine.SetPageSize(const Value: Integer);
begin
    FPageSize := Value;
end;

end.
