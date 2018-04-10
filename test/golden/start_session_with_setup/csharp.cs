using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using Kaltura;
using Kaltura.Enums;
using Kaltura.Types;
using Kaltura.Request;
using Kaltura.Services;
using System.Threading;

namespace Kaltura {
  class CodeExample {
    static void Main(string[] args) {
      Client client = CodeExample.createKalturaClient();
    }

    static Client createKalturaClient() {
      Configuration config = new Configuration();
      config.ServiceUrl = "https://www.kaltura.com/";
      Client client = new Client(config);
      int partnerId = 123456;
      string secret = "";
      string userId = "";
      SessionType type = SessionType.USER;
      int expiry = 86400;
      string privileges = "";
      client.KS = client.GenerateSession(partnerId, secret, userId, type, expiry, privileges);
      return client;
    }

    public static void PrintObject<T>(T obj) {
        var t = typeof(T);
        var props = t.GetProperties();
        StringBuilder sb = new StringBuilder();
        foreach (var item in props)
        {
            try {
              sb.Append(item.Name+ ": " +item.GetValue(obj,null)+"\n");
            } catch (Exception ex) {
              Console.WriteLine(ex.ToString());
            }
        }
        sb.AppendLine();
        Console.WriteLine(sb.ToString());
    }
  }
}