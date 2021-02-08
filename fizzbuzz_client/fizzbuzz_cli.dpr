program fizzbuzz_cli;

{$APPTYPE CONSOLE}
{$R *.res}

uses
    System.SysUtils,
    Console in 'Console.pas';

procedure Logo;
begin
    NormVideo;

    Writeln;

    TextColor(LightGreen);

    Writeln('  Welcome to FizzBuzz CLI');
    Writeln;
    Writeln;

    TextColor(LightRed);

    Writeln('  ███████╗██╗███████╗███████╗██████╗ ██╗   ██╗███████╗███████╗     ██████╗██╗     ██╗');
    Writeln('  ██╔════╝██║╚══███╔╝╚══███╔╝██╔══██╗██║   ██║╚══███╔╝╚══███╔╝    ██╔════╝██║     ██║');
    Writeln('  █████╗  ██║  ███╔╝   ███╔╝ ██████╔╝██║   ██║  ███╔╝   ███╔╝     ██║     ██║     ██║');
    Writeln('  ██╔══╝  ██║ ███╔╝   ███╔╝  ██╔══██╗██║   ██║ ███╔╝   ███╔╝      ██║     ██║     ██║');
    Writeln('  ██║     ██║███████╗███████╗██████╔╝╚██████╔╝███████╗███████╗    ╚██████╗███████╗██║');
    Writeln('  ╚═╝     ╚═╝╚══════╝╚══════╝╚═════╝  ╚═════╝ ╚══════╝╚══════╝     ╚═════╝╚══════╝╚═╝');

    NormVideo;
end;

begin
    Logo;
    TextColor(LightGreen);
    try
    { TODO -oUser -cConsole Main : Insert code here }
        readln;
    except
        on E: Exception do
            Writeln(E.ClassName, ': ', E.Message);
    end;

end.
