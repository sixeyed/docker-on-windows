<%@ Import Namespace="System" %>
<%@ Page Language="c#"%>

<script runat="server">
    public string GetAppSettings()
    {
        var keys = ConfigurationManager.AppSettings.AllKeys;
        var settings = new Dictionary<string, string>(keys.Length);
        foreach (var key in keys)
        {
            settings.Add(key, ConfigurationManager.AppSettings[key]);
        }
        return ToHtmlList(settings);
    }

    public string GetConnectionStrings()
    {
        var settings = new Dictionary<string, string>();
        foreach (var setting in ConfigurationManager.ConnectionStrings.Cast<ConnectionStringSettings>())
        {
            settings.Add(setting.Name, setting.ConnectionString);
        }
        return ToHtmlList(settings);
    }

    public string ToHtmlList(Dictionary<string, string> settings)
    {
        var sb = new StringBuilder();
        sb.AppendLine("<ul>");
        foreach (var key in settings.Keys.OrderBy(x=>x))
        {
            sb.Append(string.Format("<li><b>{0}</b>: {1}</li>", key, settings[key]));
        }
        sb.AppendLine("</ul>");
        return sb.ToString();
    }
</script>

<% string pageVariable = "world"; %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
����"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
<title>ch03-aspnet-appsettings</title>
</head>
<body>
    <p>
        <h2>App Settings from Web.config</h2>
            <% =GetAppSettings() %>
    </p>
    <hr/>
    <p>
        <h2>Connection Strings from Web.config</h2>
            <% =GetConnectionStrings() %>
    </p>
</body>
</html>