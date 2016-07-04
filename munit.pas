unit mUnit;

// Простой пример использования Notify-send в Lazarus.
// A simple example of using Notify-send in Lazarus.
//  https://github.com/GuvaCode

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Process;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    procedure ExecProgram(cmd:string; OutputStrings:Tstrings);
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  ExecProgram('notify-send "Message Title" "The message body is shown here"' ,nil);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
 ExecProgram('notify-send -i error "Error" "File not found"' ,nil);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  ExecProgram('notify-send -i important -t 15000 "Attention!" "Show message 15000 ms"' ,nil);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
   ExecProgram('notify-send Html-Style "<b><i>Hello World</i></b>" ' ,nil);
end;

procedure TForm1.ExecProgram(cmd: string; OutputStrings: Tstrings);
var
 P:TProcess;
begin
 P:=TProcess.Create(Nil);
 try
   P.CommandLine:=cmd;
   if OutputStrings=Nil then P.Execute  // just run, no output, not waiting
   else
   begin  // run, wait and pipe the output of the program to TStrings
     P.Options:=P.Options+[poWaitOnExit,poUsePipes];
     P.Execute;
     OutputStrings.LoadFromStream(P.Output);
   end;
 except
   // Error
 end;
 P.Free;
end;

end.

