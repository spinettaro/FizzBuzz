program fizzbuzz_cli;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  Console in 'Console.pas',
  CommandLineU in 'CommandLineU.pas',
  GpCommandLineParser in 'GpCommandLineParser.pas',
  FizzBuzzTSU in 'FizzBuzzTSU.pas';

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

var
    cl:     TCommandLine;
    parsed: boolean;

begin
    Logo;
    TextColor(LightGreen);

    cl := TCommandLine.Create;
    try
        try
            parsed := CommandLineParser.Parse(cl);
        except
            on E: ECLPConfigurationError do
            begin
                Writeln('*** Configuration error ***');
                Writeln(Format('%s, position = %d, name = %s',
                    [E.ErrorInfo.Text, E.ErrorInfo.Position,
                    E.ErrorInfo.SwitchName]));
                Exit;
            end;
        end;
        if not parsed then
        begin
            Writeln(Format('%s, position = %d, name = %s',
                [CommandLineParser.ErrorInfo.Text,
                CommandLineParser.ErrorInfo.Position,
                CommandLineParser.ErrorInfo.SwitchName]));
            Writeln;
            for var ls in CommandLineParser.Usage do
              Writeln( ls);
        end
    finally
        cl.Free;
    end;

end.
