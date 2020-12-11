program Project_Form_Embedded;

uses
  FMX.Forms,
  Unit_EmbeddedForm in 'Unit_EmbeddedForm.pas' {EmbeddedForm},
  Unit_ParentForm in 'Unit_ParentForm.pas' {ParentForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TEmbeddedForm, EmbeddedForm);
  Application.CreateForm(TParentForm, ParentForm);
  Application.Run;
end.
