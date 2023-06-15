codeunit 50221 FakeConfigurationProvider implements IConfigurationProvider
{
    var
        ConfigurationCompany: Dictionary of [Text, Text];
        ConfigurationCompanyAndUser: Dictionary of [Text, Text];
        ConfigurationModule: Dictionary of [Text, Text];
        ConfigurationUser: Dictionary of [Text, Text];

    procedure Get("Key": Text; Scope: DataScope; var Value: Text): Boolean;
    begin
        case Scope of
            Scope::Company:
                exit(ConfigurationCompany.Get("Key", Value));
            Scope::CompanyAndUser:
                exit(ConfigurationCompanyAndUser.Get("Key", Value));
            Scope::Module:
                exit(ConfigurationModule.Get("Key", Value));
            Scope::User:
                exit(ConfigurationUser.Get("Key", Value));
        end;
    end;

    procedure Set("Key": Text; Value: Text; Scope: DataScope): Boolean;
    var
        OldValue: Text;
    begin
        case Scope of
            Scope::Company:
                exit(ConfigurationCompany.Set("Key", Value, OldValue));
            Scope::CompanyAndUser:
                exit(ConfigurationCompanyAndUser.Set("Key", Value, OldValue));
            Scope::Module:
                exit(ConfigurationModule.Set("Key", Value, OldValue));
            Scope::User:
                exit(ConfigurationUser.Set("Key", Value, OldValue));
        end;
    end;

    procedure Delete("Key": Text; Scope: DataScope): Boolean;
    begin
        case Scope of
            Scope::Company:
                exit(ConfigurationCompany.Remove("Key"));
            Scope::CompanyAndUser:
                exit(ConfigurationCompanyAndUser.Remove("Key"));
            Scope::Module:
                exit(ConfigurationModule.Remove("Key"));
            Scope::User:
                exit(ConfigurationUser.Remove("Key"));
        end;
    end;

    procedure Contains("Key": Text; Scope: DataScope): Boolean;
    begin
        case Scope of
            Scope::Company:
                exit(ConfigurationCompany.ContainsKey("Key"));
            Scope::CompanyAndUser:
                exit(ConfigurationCompanyAndUser.ContainsKey("Key"));
            Scope::Module:
                exit(ConfigurationModule.ContainsKey("Key"));
            Scope::User:
                exit(ConfigurationUser.ContainsKey("Key"));
        end;
    end;
}