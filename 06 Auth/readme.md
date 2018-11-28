# Authentication

## Forms Auth

Modify web.configs of:

Claims Web

```
<membership defaultProvider="i">
      <providers>
        <add name="i" type="Microsoft.SharePoint.Administration.Claims.SPClaimsAuthMembershipProvider, Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" />
        <add name="LdapMember" type="Microsoft.Office.Server.Security.LdapMembershipProvider, Microsoft.Office.Server, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" server="sp2016.spdom.local" port="389" useSSL="false" userDNAttribute="distinguishedName" userNameAttribute="sAMAccountName" userContainer="CN=SharePoint,DC=spdom,DC=local" userObjectClass="person" userFilter="(ObjectClass=person)" scope="Subtree" otherRequiredUserAttributes="sn,givenname,cn" />
      </providers>
</membership>
<roleManager defaultProvider="c" enabled="true" cacheRolesInCookie="false">
      <providers>
        <add name="c" type="Microsoft.SharePoint.Administration.Claims.SPClaimsAuthRoleProvider, Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" />
        <add name="LdapRole" type="Microsoft.Office.Server.Security.LdapRoleProvider, Microsoft.Office.Server, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" server="sp2016.spdom.local" port="389" useSSL="false" groupContainer="CN=SharePoint,DC=spdom,DC=local" groupNameAttribute="cn" groupNameAlternateSearchAttribute="samAccountName" groupMemberAttribute="member" userNameAttribute="sAMAccountName" dnAttribute="distinguishedName" groupFilter="(ObjectClass=group)" userFilter="(ObjectClass=person)" scope="Subtree" />
      </providers>
</roleManager>
```

Central Admin

```
<membership>
    <providers>
        <add name="LdapMember"
             type="Microsoft.Office.Server.Security.LdapMembershipProvider, Microsoft.Office.Server, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c"
              server="sp2016.spdom.local"
             port="389"
             useSSL="false"
             userDNAttribute="distinguishedName"
             userNameAttribute="sAMAccountName"
             userContainer="DC=spdom,DC=local"
             userObjectClass="person"
             userFilter="(ObjectClass=person)"
             scope="Subtree"
             otherRequiredUserAttributes="sn,givenname,cn" />
    </providers>
<roleManager enabled="true" defaultProvider="AspNetWindowsTokenRoleProvider" >
    <providers>
        <add name="LdapRole"
             type="Microsoft.Office.Server.Security.LdapRoleProvider, Microsoft.Office.Server, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c"
              server="sp2016.spdom.local"
             port="389"
             useSSL="false"
             groupContainer="DC=spdom,DC=local"
             groupNameAttribute="cn"
             groupNameAlternateSearchAttribute="samAccountName"
             groupMemberAttribute="member"
             userNameAttribute="sAMAccountName"
             dnAttribute="distinguishedName"
             groupFilter="(ObjectClass=group)"
             userFilter="(ObjectClass=person)"
             scope="Subtree" />
    </providers>
    </roleManager>
</membership>
```

Secure Toke App:

```
<system.serviceModel>
</system.serviceModel>
<system.web>
    <membership>
        <providers>
            <add name="LdapMember"
                type="Microsoft.Office.Server.Security.LdapMembershipProvider, Microsoft.Office.Server, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c"
                server="sp2016.spdom.local"
                port="389"
                useSSL="false"
                userDNAttribute="distinguishedName"
                userNameAttribute="sAMAccountName"
                userContainer="DC=spdom,DC=local"
                userObjectClass="person"
                userFilter="(ObjectClass=person)"
                scope="Subtree"
                otherRequiredUserAttributes="sn,givenname,cn" />
        </providers>
    </membership>
    <roleManager enabled="true">
        <providers> 
            <add name="LdapRole"
                type="Microsoft.Office.Server.Security.LdapRoleProvider, Microsoft.Office.Server, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c"
                server="sp2016.spdom.local"
                port="389"
                useSSL="false"
                groupContainer="DC=spdom,DC=local"
                groupNameAttribute="cn"
                groupNameAlternateSearchAttribute="samAccountName"
                groupMemberAttribute="member"
                userNameAttribute="sAMAccountName"
                dnAttribute="distinguishedName"
                groupFilter="(ObjectClass=group)"
                userFilter="(ObjectClass=person)"
                scope="Subtree" />
        </providers>
    </roleManager>
</system.web>
```

## ADFS

[Configure ADFS](https://sharepointobservations.wordpress.com/2015/02/24/sharepoint-2013-and-adfs-3-0-lab-environment/)
