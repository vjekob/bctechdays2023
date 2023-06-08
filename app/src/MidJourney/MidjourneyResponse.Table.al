table 50002 "Midjourney Response"
{
    Caption = 'Midjourney Response';
    TableType = Temporary;

    fields
    {
        field(1; Status; Enum "Midjourney Request Status")
        {
            Caption = 'Status';
        }

        field(2; TaskId; Text[250])
        {
            Caption = 'Task Id';
        }

        field(3; Percentage; Decimal)
        {
            Caption = 'Percentage';
        }

        field(4; URL; Text[250])
        {
            Caption = 'URL';
        }

        field(5; Reason; Text[250])
        {
            Caption = 'Reason';
        }
    }
}