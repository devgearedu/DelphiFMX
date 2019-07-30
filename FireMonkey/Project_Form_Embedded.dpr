program Project_Form_Embedded;

uses
  FMX.Forms,
  Unit_ParentForm in 'Unit_ParentForm.pas' {ParentForm},
  Unit_EmbeddedForm in 'Unit_EmbeddedForm.pas' {EmbeddedForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TParentForm, ParentForm);
  Application.Run;
end.
