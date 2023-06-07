table 50001 "ScaleSetup"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = CustomerContent;
        }

        field(2; "Scale Codeunit Id"; Integer)
        {
            Caption = 'Scale Codeunit';
            DataClassification = CustomerContent;
            trigger OnLookup()
            begin
                DoLookupCodeunit();
            end;

            trigger OnValidate()
            begin
                CalcFields("Scale Codeunit Name");
            end;
        }
        field(3; "Scale Codeunit Name"; Text[249])
        {
            Caption = 'Codeunit Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup(AllObjWithCaption."Object Caption" WHERE("Object Type" = CONST(Codeunit), "Object ID" = FIELD("Scale Codeunit Id")));
        }

        field(10; Scale; Enum "Scales")
        {
            Caption = 'Scale';
            DataClassification = ToBeClassified;
        }


    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    local procedure DoLookupCodeunit();
    var
        AllObjWithCaption: Record AllObjWithCaption;
        AllObjectswithCaption: page "All Objects with Caption";

    begin
        Clear(AllObjWithCaption);
        AllObjWithCaption.SetRange("Object Type", AllObjWithCaption."Object Type"::Codeunit);
        AllObjWithCaption.SetFilter("Object Name", 'Scale Impl*');
        Clear(AllObjectswithCaption);
        AllObjectswithCaption.SetTableView(AllObjWithCaption);
        AllObjectswithCaption.LookupMode(true);
        if AllObjectswithCaption.RunModal() in [Action::OK, Action::Yes, ACTION::LookupOK] then begin
            AllObjectswithCaption.GetRecord(AllObjWithCaption);
            Validate("Scale Codeunit Id", AllObjWithCaption."Object ID");
            Modify(true);
        end;

    end;

}