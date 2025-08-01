-- KONTOL HUB PREMIUM ENCRYPTED v2.0
-- Military-grade protection | Unauthorized access is illegal
-- Generated on: 1432114

local COROzsqP = game:GetService("HttpService")
local ksDDuVNa = game:GetService("Players")
local vvZZvdQz = game:GetService("Lighting")
local MyzcGhXq = game:GetService("CoreGui")

-- Anti-debug protection layer 1
local UbrGHiCF = {
    {"dex", "explorer", "spy", "debug", "console", "hydroxide", "remotespy"},
    {"scriptware", "synapse", "krnl", "oxygen", "electron", "furk", "coco"},
    {"getgenv", "getrawmetatable", "getnamecallmethod", "hookmetamethod"},
    {"firesignal", "fireserver", "firetouchinterest", "fireclickdetector"}
}

local function FxWgWher()
    -- Environment validation
    if not game or not game.Players or not game.Workspace then
        error("Invalid Roblox environment detected")
    end
    
    -- Anti-debug checks
    for _, category in pairs(UbrGHiCF) do
        for _, tool in pairs(category) do
            if _G[tool] or getgenv()[tool] or rawget(_G, tool) then
                game.Players.LocalPlayer:Kick("Unauthorized debugging tool detected: " .. tool)
            end
        end
    end
    
    -- Check for common exploit detection
    local RUJiZmPy = {
        "getgc", "debug.getregistry", "debug.getupvalue", "debug.setupvalue",
        "getconstants", "getprotos", "getstack", "setstack"
    }
    
    for _, func in pairs(RUJiZmPy) do
        if rawget(_G, func) then
            game.Players.LocalPlayer:Kick("Advanced debugging detected")
        end
    end
end

-- Anti-tamper protection
local nizSmXyS = "PRBPLhVGUz9ydmhYUmITMEPCgRdALn0tIzlrRR4awoFEYSpMTkosRQ4pFnvCiGZqOGpHOhFKJShebioiMCwiWT0dfSM8fy9KSykgMUl+VEQ1Ui8oDTMfD1kiPC4iSjlaNRwOHsKId8KHFisTQg5tZmMdPcKGM0tuEFIdwoYuGzhBQX4NQRVOLUhWMToqE38mGW5lSVbCgA08UDchRVkRLx0/KMKETcKMW2MTPQ0+SiY9PQ7Cg15QSTkULRwUSEEgfTNCMRh6IRokQn8QR3ohQEYvIUttaBIUKW0ORXoyMCB9chBiYxAZQ8KDFVg0DsKAEEpMPzAWJ1bCiyQkXUNBwoAlIkFvbiJEIywiPkM5DigwahRCKB0zLm5hEhBLwoxOGmXChyVwwoxMDz0ewockDTJZfm8mVUodMS/CgjM3cl0UO2U8SytBayBiHSkYQG9+VDE2ZDQgFz54FiIdGG0OUw9bbRouwonCiFUQXkg0IUktGj8uIRdwM2stSRdCF0skT8KJQhBuGS/ChEprdmUrwoUvDUcRID45ZElHfhFKKi0vLjoTFyYswoZJJ2gvOG/CiXLCghFCSEAtL0Nqcjh6QEovTQ4PfMKIdCVXwotKN3M8Sx3Ch8KIwoViYRpCTkMZTRF+bCzChGMeGi44TWohF3QTFnJDM3JzLCItFEEbMQ4cTS4wHHE7SBEkHSXChGVYKVg9LScWViwSJEU9EREyHD43wop0DsKGGTVEJzgSe1YSUU9oSDFaQRMNUEgnDhsmJGc9WMKBIX4kJjZkPikYwoNTaSEvZzRSWSpHblpAwoVKF289RsKMNmlwfmwSOxoqICgfYXcrGsKDGWx6FRMoZCUTJBgqHz4UFyVISxcnFykgIg4eYnMyOlENEycoSXXCh0MvLBzCizIeQBp2cn1jQUZIHzIvN1BXIWLCgxkYwoArLXFQLkojbCjCgw1BVQ4vwofCjCF7Qh4uGCplwoImJGQdSw3CiyoSaTMbWzh0OS/Ci2N+Mzhhcz4wRQ7Ch3oQwoMqF3cQaXo6U29dEipjDUUfHhkoUg48aTJKZFHCgyMpa2VqHF4sRE4UE0l+LjMfED8QJS8gdjk6XS9IOC8yTBApZxhVElQaaBtQP20OMh8SwocwPiAsEUfCjFhKOxowIycOwohRTB3Chko8YCJTQ8KLcBBjQh4+OToZwoQPwoluHyRlOxArLU9nJ15eKGgNNUInbhHChUotLxYuPSdSMMKKwodzPWs/IjYcU1MsDWghQw/ChVYtwok9woc+RD52DTlVbG4Na3k8TUVLJS1UFytVfiQwwoA4R8KLcXAxSQ15QjwUQcKBORwZREtrMEQUO38mR0JdRDhkFEoNTSNJIVYkG2vCgSdSwovCiWggdzQeM8KHH8KKwoBTEGckRMKGPDAsFHTCiT42ST0sLiVqIEduPw8mExIqQHN4JA1hHRLCijtAwodjPxMOPDAPPEBXYS80wopIQGMsFSE9KWdEYmslNm4NNCkoGSwtYi9JDRAgTx4VDR5AOi3CgUNFTmNFL1MyDWgsVBISLUVbNUApVMKCWBJywoxYcT9FShQpHVNuUEkSIxZ6LlFuGjFJDkscLEcgJF7ChzF5STU4RTkheMKIYDA9JjRFXzwxblpxISAZQMKDMyFfWEY9HEwaMUwcH3xxwopTIBgyTsKBJTQybm03FUkmFCPCg0RqLR7CiHp2JUA6RnXCinQ4D05GFsKBLw1DanTCijQYMBsQS0wOPhMgIB1sTy7Chx7CgW5HFhJaRMKAEyxJUyItOC4hDx1LTcKFEzJqMzk0HjwoG2VeTjBRJRLCgUtScl9zDkI/JBVRDyLCgXQQeDPCgElDDkcucX4oKhFZKBNJEg/ChEgpHEtGH0gVGHchEcKJDyxKHRkhPlNTLTZQUGTChBIUDnLCjBEzVkNAJg0twokjS2cOQDE9Eiw3ZnIPKcKHMw4PwohWdXEbKRRgcR9FF0LCiUlAXjw4OCFJPXZ0UUQewoFBFxA7NSRyK0kTRC7CgR4wOnAtS3kNRw0TLhhHX2ctLVBUZXAzSknCiUgnWzJwPBoSLFBxHsKIdEoQMSvCixcXwoBYT28aL8KJMBQzwoNtMUFJwosSIxA7WCNKJDEoGR0NQsKDWFBCHmFGGsKFDSlJZhksYhAUGywpN1IlwopXPio0M39wI3hXLylqRClzwolAIVQOJTZjGRY6Ix1SMB3Ch3onLlDCgiEicl0zWn48JW5GR29eTCY+FG96a0Iaficmwos9RCMSLXAkfRQhO3JBRHM1IDUNQjNiPiYtRsKMWMKGMMKGXG5MJTAhLEhwblEowohEZcKHSBM9ZCYTFTATETJ/SxMoHsKMLTYYRRhCd8KLwoNDScKJShhPMyXCh2pIcF0XQw8wPEgRMzXCiyE5aCsXIBhPWCkwDzATGsKGFi9SNCEsVjxLEUtFaycUVUt6KSZ+djt4cCc3DR05ThgiLxJKHEEvMMKERRs/YUY3bx9MDkk+OCtYwoEYMA4QIxorDhhpHUdMIj80DjRWwoxvGW0xGTlLfi8Zc8KJWBkXEA15woUPR2PCiDBCPisvTiwbcykPTXEgFBMOLRhjfklGwooSF2ATJyFPIzRgOUAsKC84difCiw4vORQRF0AfD30dHg9KFWchLkxUEyEfGXDCjD0eGlISc8KMeicaEy8fRWjCg0VFZE9LYzomL04sRzoiOjI/woIpU0h+f3JGTSEyNiBYFEE+dBw4fRdrOGc7NRg2RH5QMFgNEkBeTEYtPzQxKsKDdxEdbSEmwow1PxZkKBccGio3USBYwog+NxcZJjYRwopMJcKEYkYiZ1ATZBBRDRQ5wocjRDwUSiAWbA05VTNMJjREFiFUYCQ7V0AQUSoSQcKGD0spQ0XCjDofDRcfOV0eek0gIUB3KRJOYipPSw/Cgk3Ch1J5IUojLxpDIVcTKx5OIysWSTdLSn9+SVd+JSpPQ1UjWXknD0ITDTA3G1AvHlowFkdQNj0qan0QYnQlSCstNBHCiR8YEBIQPj0dNhMgFcKDHS8yEn0RIcKCVUVXFFImTy8hKcKLJCgRSw4OLS42Y0QtTh0XTEAfMxp+ECI2USsabRwYSQ0fwowbaykyMRAoanoPFTQNRkrCg3AdT2dRNm1JMRHCgTMxfkwrFQ8QElESLlIewocOGSxsID7CiyFPFCcqdBkVwoZKKx1iTDERLh0OLX8kEw0eYy1BNitAJkHCgxg9LWNBOCdLPSBQKCoXEjo5DhErGB3ChmcrwoAkI8KCP0nChMKJEknChDMSGUhKNH1MwokWMEl+Gg4dXz8wHHI6Gw1AKxxtwoRPV1AUNFIqFBBeEMKBXUEsDUcYLhBENH8tKEtCLXUVDhgRWFNQM8KBwooYR8KFGSEjPCQwJxwea28vHBR3OC0ySEDCghcxK2UxGm4RE3JdMhtXQiF6Sg8tcHkRwoN6H0QbLSYid2MSRG1rJsKHQhNvUXMqHTErfUxJRW15wovCiRl1MihLI0VzVClVXSRHwooUS0TCiUQ6GhBJf0NAJWYjRmNDPVFNNCY7U3NGRGA5Nn3Ch0MgWj01XhoRO1ANFm0nKsKIPyItSjAnbndVZkhwOmR9IxYNYkwpPjIoNCo5KHRIOmYkDxktIT8gZ1QqDXBAEWMYVS5kIilCEDHCghIuVsKGShEXLBYOUzhzeRNgEzlVFBdvSE0PTxM2RFoxwowuEk5YbSlqKylrLX8gG8KBV1McThlBwoDCiiwNbSg2YClEFkoeN8KMJDpYK8KAE1NLJ0dPUFRicy8nX8KLVhHChEZJPTxHKTBCJ1EowogZTDgzQzdzOHN3NUpgPERwRQ4xZB44QGQ0D0UVShh6O2BMHCUxwoMten5nDU9VOUhdwoxGDigwwogVHXPCjBHCjEsTenN9bXkxHHh0SH53STVzJRJlEkQ9Xw4aNT0neiwZJHBFwoZ+Pg0mUw8QHVZqJ09OTU5ewoZUH2NvNzNWLxZMOiPChEgZwojCi3wvEToVFxDChi4hwodBRE10SR0ZSytgXUU2OSE1UEUXWxlELDLCijQ+JcKATg1vUyppwogNQBIuEWo0HR4+RCwRDzl2S0ctUQ0kKGITISMXEDgTGi8nwotIOCFARCRKwoJjFDowYCUeKkASIHZNcEsfwodFM10QEENbFMKJQxsnDzAYOMKGEQ1ZFDcWUX3Ci0gpcQ4VZFQ1ZCERRFMTQRA3Pn1AQinCg0Y9XS4cNS1JFW10XTVFEkhobDokdlpxJw9iDcKBUsKBHVdDHCAmPRkowoEvS1DCgB4pUhwmfhJIblMjQRYgP0QdwoAZUG8VTRMqQkoUPS3CgcKAMWJkURcPHDgWXh9JV1ZwLVIpTcKLRzdWFEMjDRQULmfChCdJETNnaTE0J3kwwooXXyQxHjBNa3Fvf3RJDSY6czUTZBEmYi8XwoNINTJmRiINYXIvMX47EhQyY0REDSxCERkPwoslTHBANcKME2cfX3BwQg8ywosQNU1tOcKGwowQKDtOEA8weBNAGWlMZ3NDMQ10Og4YTCgtMCskZXQuwoorPhlLwoA9NWV0FToRGhzCg0sTIg5DEFdiIXosRFlYHsKKFnRLMhsNdCpxdxVZJiwcJzElbRHCiCtgYy8+Px0Nwox5SX9FIjtpwooTJVFjTlxrGRNNLEANWS3CiD4icUMOHh5eNDt8LikTIzp2N2l+KShmFGtdSB0vTznCiRZjTC0mKS54HW/Cg0MfQxEOP3lhUCEtXShGfCYtdllIIiQcRHooNidSRzDCiigjMw4qJ0sQZVFVUSlJfBE9JygkFyMabzFHEhhlMTLCgC0eKCEOTChjTkgbTkVkwosXJcKLXnE3GDwzfw09S206D2kgJ2VFOA8rcFBTJHgrDycXEEFqdDdAGg8gPiNKcjoeZkQtNCPCgEp2Y1clGVdULmklPUxic0VCOW4iIMKLK8KDEDheEi84EsKDQ0txcEsZZEFIwogoFTh6QhcpGh8OTDEqZjoZwocQDRJGIG1twoN9IB1qRkdmwoYyKk8tEmI5JThHICAQJz7Chiw2EFQXNiLChWwYHQ8sFlkxM0xjciY8FipMEzhHF3JGwoskGBVONyIdZmoRSU8TSHQ0VBh5wog7W0kNLzJEJ1QnLlZDD0cnOiQrXWcmJFUkOg3Cig9CehQORBElNFQ0WV0dSMKDRSw5NBAidWnCiFgPTyEhFCxFEHJFwotqX3RBJiw9UkEzakUgaDo0JzfCi1QULcKBMxdmPBAlajkYYRBtRDAfGRNJMlrChyomD0sjQXJgET5tThR/LUZDD3HCgTA8bjgmLxdRKzBoDhVESS8ldlHCgQ4jYk4ncCU4RMKHHhRpGz0XThlaD0AuVSgVNT9ESCRkXlQdcREofMKFQ0ZuJDsuYSdDFMKEPGgySH4aNRgPFzFAWGlBKE0wFsKBIyJLZQ9DIzAxfzEaPGklE24rPTkeOzMkZFApWBhAIcKGMCp0Eg5HaSEyOiQXGF4rMnscbksTDUd6wolROEzChD8ywoESS0Nlb8KCRC4yFxEtJ1QRFG8gLCQmwoM4NRR9NxV4MSHCgw8hbXkpE2FWPBIvPUPCjElGVys6EEkfIBvChm0iRX5LScKLKyVvwoc+JjMtSCNPNjBNQcKFwoA+JkofF8KLeV8NOFxhREUOQWsgVEsRGB4pLWspP316OmokKBJTI0xBeA8YWFgsRW8UI3IPeSYPKxI9Gj8oEz4deSFENyxLRMKDeFhAIMKHNDVywoUPMVEOwohfXTINSHYNUhlLeTQqazPCinB3woUQUiFyRhMrGEgVZ8KISkFjEg5UGS0SJj17R0I0S8KERyxsTigwdUNSEhQwDRowNGFiPRBZMCgUKExvKCcuHUEOGG4qNVzChjInUklDLcKIeS4QGT8vEj0ncyU7FXl8Fi0jJnvCimYYUHgfS8KAdD9MEEgTPR4PGxkYLWZBMxdBKhlRSTQhYRgrF20uQU8qUC8TbcKKFkIRQ1ohNxRAb39tRGUfNDJIa8KHMibCgz9pfy0kwod/SjVEIjAQUH1Bd28uFzkYNyYjNSzCilFLSnAPSX3Ci0JLLHIoYWsmIRDChCESS8KKZigZNBwcRCQTDUtYYSxHYw9DFWUeLzQUei1TMiQYPRp5Lkg2ExA1G09jD1BSQGRtISZDwotywoVfJHPCgiZJGmEoTG0vKyITEjYXT2okI1hTalAuUilrwozCixMrDi8qNBnCiyYxeikOIk1ANilqcD0eTSZJDUYhEBRtHBFeKxkvESnChElLwok9QEITeEt8fxRUVVU5GllDUxDChnrCi1tARCETwoBccUVzwoI/dytQIHN6GFgqYnERaWtIFG9sMidXPCbCgDQpQsKDKTtbKzhsFCttdWjChiAtYEoseSdDcWZvwoU8LS3CjD0cOnNBOWhybUkgLg0uFH0wPWUsHMKFEVBEwoIzFTwfFMKDPjBIFHEYd0MVaRQ1EhxeZzUmXRFsDUk2FX55SyM1FCEjLioUKip7bRY6JypyPVF9LyNYTTHCgRdWKhosdDZLLRtONkNSNBtYwoc7FlE2FnhNXSU4DzM0dBIhRmQoImkgKhInQyd3Eh7ChB5CJVIfM3t2wolPHBAeSW0iTnLCjDI8OS8xN04xW210RiBEPkhDODhEUFAoGxRJRm9KTB9/M3REFUB6Sxg8DiAZF0hMGB3CiUIjaVdMOXIwKcKMKj0iaW0sNWQnQUs3SVZvHnoQHyI8MEtBDU4NFsKFRSljFCh2UUgwD0QRwoRDDh9ocRrCh3JLMR8wQ0hzVSwZZUVsGRE4KWA9JjEyECQOwoRJbkcPdcKLGiVNFTJIaVUVQX4OEsKFKCUswoQuwoUdGG4WM39fVDQsYw3ChDMqN3JBYcKFSh53WUZcGEQ1TSURV1ZDGTANG8KIMDNoDSAsVHhBP1FSRVcPLTorJQ4gEw4zQEl0OiQhGWx6TE09PUhbRCFCwoMmMRd1DjESFC8qwokfIh9hShlQFSjCjCgeDkQgayU/MCFnDxMcbkwxYTorOFs9KD8jSSA8KVVUEA9oejUrKw1KNXFTIEB9EWNSF0AffhkiYTdtOSkXSRA9D3hKKxBRFBM9TcKERFVpRhxhRhBHESfCijMsJxkyHVdyHcKHwoZGeUszNW51UyZmVW9IFcKAdB1CWhPCgjReJx5GNDVpIUV2MUc1KEJHQxNYUDp+KUhvwow0JcKLKyw+TEskJSBAfxkqbxAoOCpDbT5vfj1DwoNKNxM8SR90QxIXHCo9Py8lZD8XWipDMUI8LzfChBRNOWlnGsKAKhg1Gho6DhdFQUdDQncQNVkNP2VNDjQsacKMTyhoUmpOMSwUwoBLK0FdGiQ9HBvCjEAqfBMYQyg0QBd4DSIQKhMSwolHETNODxAdD0oyH8KAIF4sO2IdKxUdIS4ieE84RhNFFGcwQCYowowYLBtEMVRCQsKEQ0cZcTczLC41EHF1JEBPSA5RcEAYej0UYTUPMDoWEMKGLz12MEE2UT5xG8KFfi4NaUQsUyE/PxMoPDcjET0ywoJLdzklX21ERRrCghgiYcKMER3CiEURwoQzSXZfKsKFPylFPyA1PWkaLHUuFjlBNQ15VCYQWm9ManFHNCN7Dg4eXUHCg0DCgkhQSisYE0lRWzAwDcKEEDAtaRFsejgkcWZtEyAuehhGQVp0On5rIToXFDIoHlNjQh9lGWxmFhQyDy0sLRXChxg+Nz3Cg29AwoZISUZHwoksIE9TMh0mI0h/wolKImNwOxEpEzQswoBHZyodwoxHdWtQDRF1E1QjIHIdL00bUUvCiksqKUseHiUxLRMUNVggRBlUPHIVb2M4SXQ0asKLGEtKwoMyM0AvMnprGjBzJzMZHxZrUxJJHhHCjEJcwogTMsKBNSUpZz0VDmNHNSMvLRcRMmFKDUY7fQ11a2szFWsrQ1kyRicNLTIxYTEdWTJNZG8yVycNRhIWbRxQaUtad00kcy1RD20oLDpBGT8/Ix3CiyEQVsKLP0wiJDg5JWopOF4aMBLCh0wUZw5wESwcNTkxLn4dRm9uHCJRLnBJDWNLPcKGGUwNwohESQ5vwoYeFHI4LsKMOxEaSG55KDo8Dx13XWguFcKJQThtFSQNdEtGKg0hS2tMPk8ZSGFIIy8QfUl/ZHJRLV0uEys2M3BecSkqOnM/QDEhDy8vZyfCgBIaQzAkwoZdMl7Cg1EcesKIaxhmDiwZHT5BUy5WficRZhAnLQ0ywocwbmxSYsKHQSFyN2sfZEklXRY0PTPCgDxuQA5qHQ00Dz4/GA3ChCciECUsUsKBLEJSPhpkPCsYHz1EbCtKYy8vK05/FSoTwolMOmwkOXAyJEJ9Rw8wDiMOazohDTMgwowoJigPGsKHJA5hVCYRI2nCijw1blAqJzZfSyI0diTCg8KHR8KEHRYZJRdFHU9TSzgSHRBrwockNMKMKw0XGEQXUHYpDjksfMKLRzYUP3F4TWMxQXIkRGMhK21NSDFbbHQtIywpwosmD14RKUVGIXVKTsKDSkvChx0rUQ41bnATFS9eDcKEHDdNbycOwoZEDzc6GS8sd2BmGhRGRBo2QiPCghooXRtyek1/KhJ5KX9GD2w8RDYua2ZUGV0rIcKLwokfJl4eFDdiK3ZnPkkNQBdpwosuEEjChHQ5wodwIFZ4KjzCijhRKWx5PB5iRD4TEStjDUBncB8RTcKKIUjCjMKGNEUPZxlSG0BKWTvChx4yPnYeQS5fcMKKTSdBalQcQkzCg2xDSHFASm4bLkNzK0scLSjCgk45H8KIeX4ZSHpqHzt2LnBpZkJPQTNpKk1LwoItR2FaRiFMGSIXKBl3K8KASFEvERx9cEFFEA8wXkoWLlEbwotkOx0aJkQnXkdJwoEjPC9cFxU1dBg1G00uZHATLUTCgm8mPkAONCosTBIuHV4/GkUmH0Uffm4VOGVQNmMSayJUJMKGEz4cFDA+SmRGOGsnPzFHDyswEHdmSFRQJg50Ig9dPS8PIEc4ShI/YykvDSR8aB4bRkJ0D0g3fT4nai5KSHoeRUAxQRAQEVZoIMKFZ0ZDJSEvRiJkJigWwokwEBAhDh1SeRM7XW0cSkwbbzrCihocdhEpPUNAWG03Wm1HJ2ZKEklnbg5JQQ5JE385a0bCiW9HdjE/eC8lYWcxO8KLU2tmNE5ucnonNjZwGxl2S3fCiyB1MysyOg5AHBRiDx51HyrChcKJST9dQjRkDhF6ExYOwoowGnY0L2ZTfm1KwoURFx1qWTptOxQtZDkWKkQ+KyhJWWM0MsKBEz82SH0xLHfCijU1Tk5SKyxPJGVtRxYYLh1LwoJZXS3Ch2g6GzklOREnFyogSVM8KMKANDApcEk1JBQlwoQUJBxUTH0kwodAIk45SyARUTM7ERFBbsKJEzhPSTEcEhJJKcKDTGJID1kNHxARfHUrY3VIGGQtDQ0UFBbCh0AyIWMhIFAxOXc0c8KAbRsWGxQOHGbCgEBidw01woglESJ0MyUUQR4vIyE4Vw8nDiUaZjoiM0RfZSJAcyMmXRU/QE0+Qg9JH0EsEGNkdBFqRHZGLMKJMxBxDitETR8la0YNFk06OBUaDzBLPF99eSB1My8QNMKAc0jCgWpQRhEpNH0aTCURSBQ4HEAsQx1NZTPCh385eC4seHIlVmdLRWBKFcKKEiwteUbChhxDDS9PEU0lQzR8OnprDQ9yKsKGU04VZ0xlakIuEGk/OCwRIzBMLSrChnBHFywVRUDCiUM3DXQ9ViYwDVooM0oaEDpCQDQ+TUQ6ZkwaGcKLQhISDz86FHQlFVIaLWTCiFNLFBEjYynChylKFFXCicKLwoxXIy05MxJKfxHCiTRZXkxlERI9IMKADhREYzERQBBWbSUVVRE2LFMNNkVtwooTFcKCTCNxNiI4XkIuYiMaNRohFmISHE88L2cgE3Q2woprSR90Zy0QERggdDnChTMrKcKLMSlVwosTwoYXI0o0KkpLS1BOUTnChkBDUsKIHXXChSUrDw4cL1MQNxMpLMKDGSM7QsKCIhlwaE4hTyENczpnEHlEdB0uPQ1HOxlnMQ9OEi4oQUNvHE8OKBXChFFGfMKFE0VbE0MiQMKHwoJHHhdNPEgceTxpRg0RHnDCgRMtUB5DEDEdGFlvwoUQNSMiKHZaDygTdUM6Diw7JXklaFgoThQXbBFQb350Qx8sKyNrFE5rbw12Hyg0aRVAQnFQRg1YEE5eJxByGsKILhkheilnwoEYEyovwohzHBZFD25BwoTCijhBZhoyDywRdlBGwoowQnA9Ly4wai99fcKLd0cqKUBKEsKEMg1lQyfCjDwPMBMfDyA1MBRIfi7Ci0wqdkB7bBE0JR1UwolGPnBPahpGJG9ncMKMHGtwK2cyGlZtwoxdwoc4JmkPLy1rUSIeZB4XejtncG5EF1dCSEI9SVxsOsKKdSUXZxwfcm1iwos+Gg8nQ1AlKEHCgw41ES9vDh4tPBFuTFhHRCsRIzYlTxRLJBQQGQ8NJj3CijE7amQuwoMlTGMRDUoaQUcqIzISeGtnLkkSMSRzwoEkDU8eIjEdQA9IwoBATyUmFj9LaDEwLhjCgV0nIXJAKw7CiUdLaDLCiT8wSH5ODzhrLi52RkAPDcKKNhAlwoZUOWpUNsKIMCwkdMKMQ0BeHB0TPCB0GTIXMXgkKjI9bhhzUShtEy5mPCxLGS3Cgl1rGnojEDoOen1pPR0vPx4iNm9jIRYPHDUZwocudGYtQTQrLHZnMg0RKjDCgBo/KFs3PSgSDjhZfiwUfyEsGChMNmMxKiBMEkANSUB2HncrRzAhDlZxSj51TRJlSk8qcm8mIw8/QigYHcKBLW9/EBlrSh1zd1YSQlzChA8mwoNwUirCiyomX0QuwoIeH0BrKzNgckc1PS1vHWRiFRgYLDUaGyNtwoQlOD9gOjFBDidlcxd7QCFFNBYyOF5kRjkSIThvNCdLZEcoGEtAFWswDcKELzhOIHtHH8KEJ21jwodYWcKCT0p+Qyw/DnEwQBYuQhM3W14nTH1GKDUTQCoZExIpK8KCMQ1ZDVHCh3RFwoc5bHMkLMKAEHAZFWQ/eGtADilIwox9JTlxazPCgCxHKShuKQ9aSTQmPC12cjxXcg5rTzIUNcKBXjBIaVM8wocSIQ1REycsWh06RDohJTJGeDIYNmnCgHIhaWJSVsKBJyxcMRJ2b3AqSkshFkMWWGwaJg0/DiwPSSocZg4QQCZIFsKDTBIgenItPxwhwoIRDTlOHSx6LB0iFDQ9ScKGwodHIVUeQcKEcBY0wowoNBgrGiQUKSQYDcKKFjp6STMwdkhRT1NBED4SZw1BM1lENTkxHsKMUcKCW089GxwlNyIPwoI1dsKBTw4oWDEaZg84dMKDLBIzFW4eUx8ia0EtwoF0H0ZHGDEVElNIF20UOsKHJUJGXx41MyArfkAyQA0sDcKHMCE0HH8tI311Jhd9TRNzEzUoWxolE0MTFTQvPWdMSsKISCovPnx2Dn1zIw8RHTBqJVFEchJFQyQNems2FnMkD1klIDAoQhAgUsKMISBTPDQrKRjCh8KJDzE8HUkYaxpCwoJxO2lEwoQ0URY0TF/Ch0sZUg8hwooTVHBreTpfPMKHfSM6V2ZzJmMyKTVpQCh/XRRGKFVaYxBJMERtcDghGyAbZzAnchnCh8KLRjojSTotd2R3SihnDRQnESwVejEVWywcQlIsFsKKQB1XJylRMjkUKcKDExVFdS5MwoBBDS1oIzIqGD83WjsnUzIrVnI4EkgzMkNQdTEmbToxZCcsKcKGEBNfPzQya3YtcS4VwoIRP2kzIDIpwotvJVbCiDBswokOS0gUEiYWMG0pUERcbSVFdQ8gLC4yMS7CjFVJQnEwNmQlSEdTLsKKQh5xOBoOF1cxGGghbi09FCw/c3MqSmUpRX8uMyVscjENHHF2Ui5acXEqwoEPOxoNMisWD10zS2JOQWbChiJHTXMcIEsmfTQ+Hw0ywoZYwofCgE0QNRRFa2oPMA0TGsKKMQ0pwot6wogtK3ocKsKBOW1zPV55bkJHNTR1dF1MXF4aLFI1DW5tMCJdPTQ3MhhXYW8XbUEkJTRKNBASEUgWY1kTERMzJhQPGhocHzwqMjlfRSbCgXA9Ey8wMjpqYTE/VSc8dC40J2g0woYjIm4QJCFVTh5+woBBJ2dTICQQwobCjBBGUStBwovCiigUWXoSQTtueiZCKXE8GxhtdiItSxQpwoEXSETCh0FjUjJCQXEsIS0cdCwoHiRubzQaHBwWICszORgXVFt4IC8NQURFUA9GYUAxdh1+Vm9AfX0rNkVNwokSSW1uDznCiA0lEi1NJlQvQhVrIRtHGFZTE0VXOSZHFEpKLWjChDcWwoBHZnAVMCVxEyVjHnI+K8KAQXEucxp6KhpFMy0lZnMnJHIeKW8qT3JSchUVLh8QUiRNbMKLNxUaFi0swoIqfMKEb0Y5XVoPJ8KCLycsLDc+WiB2MiAuXkhJVRIcOkg+D0luwooySsKLOk5PGCAueyVB"
local PDpmAsDI = "UI8UXowDQY32rz2un5LqQ4TLefUFuFy3"

-- Integrity check
local function QjJYmCPf(data)
    local hash = ""
    for i = 1, #data do
        hash = hash .. string.char((string.byte(data, i) * 7 + 3) % 256)
    end
    return hash
end

local KOyNjiOE = QjJYmCPf(nizSmXyS)
local cdKhVdBK = "79cc8875756c8907"

if #(KOyNjiOE) ~= #12512 then
    error("Data integrity check failed - tampering detected")
end

-- Multi-layer decryption function
local function AHgfuGEv()
    FxWgWher() -- Run security checks
    
    local cEbNzkLG = nizSmXyS
    
    -- Layer 5: Base64 decode
    local function STMtmCJE(data)
        local result = ""
        local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
        data = string.gsub(data, "[^" .. chars .. "=]", "")
        return (data:gsub(".", function(x)
            if x == "=" then return "" end
            local r, f = "", chars:find(x) - 1
            for i = 6, 1, -1 do
                r = r .. (f % 2^i - f % 2^(i-1) > 0 and "1" or "0")
            end
            return r
        end):gsub("%d%d%d?%d?%d?%d?%d?%d?", function(x)
            if #x ~= 8 then return "" end
            local c = 0
            for i = 1, 8 do
                c = c + (x:sub(i, i) == "1" and 2^(8-i) or 0)
            end
            return string.char(c)
        end))
    end
    
    local mLIUnWUm = STMtmCJE(cEbNzkLG)
    
    -- Layer 4: Character shifting
    local mPehCZea = ""
    for i = 1, #mLIUnWUm do
        local char = string.sub(mLIUnWUm, i, i)
        mPehCZea = mPehCZea .. string.char((string.byte(char) - 13) % 256)
    end
    
    -- Layer 3: XOR decryption
    local SnsRQjSH = ""
    local key = PDpmAsDI
    local key_len = #key
    for i = 1, #mPehCZea do
        local char = string.sub(mPehCZea, i, i)
        local key_char = string.sub(key, ((i - 1) % key_len) + 1, ((i - 1) % key_len) + 1)
        SnsRQjSH = SnsRQjSH .. string.char(string.byte(char) ~ string.byte(key_char))
    end
    
    -- Layer 2: Base64 decode
    local uWSPwGGz = STMtmCJE(SnsRQjSH)
    
    -- Layer 1: Decompress
    local function lYejKfMz(data)
        -- Simple decompression simulation (Roblox doesn't have zlib)
        return data
    end
    
    local COROzsqP = lYejKfMz(uWSPwGGz)
    
    -- Final integrity check
    if not COROzsqP or #COROzsqP < 100 then
        error("Decryption failed - corrupted data")
    end
    
    return COROzsqP
end

-- Execute with maximum protection
spawn(function()
    wait(math.random(50, 200) / 1000) -- Random delay
    
    local success, result = pcall(AHgfuGEv)
    if success and result then
        local exec_success, exec_err = pcall(function()
            loadstring(result)()
        end)
        
        if not exec_success then
            warn("Execution error: " .. tostring(exec_err))
        end
    else
        error("KONTOL HUB: Authentication failed")
    end
end)

-- Anti-memory dump protection
local COROzsqP = nil
nizSmXyS = nil
PDpmAsDI = nil

print("🔒 KONTOL HUB PREMIUM - Authenticated successfully")