

WITH cte AS (
SELECT clean, sum(totals) as totals, CASE
WHEN clean LIKE '%���u%' THEN '���u' WHEN clean LIKE '%�q��%' THEN '�q��' WHEN clean LIKE '%���_%' THEN '���_'
WHEN clean LIKE '%�ۮ�%' THEN '�ۮ�' WHEN clean LIKE '%�a�֤�%' THEN '�a�֤�' WHEN clean LIKE '%��M%' THEN '��M'
WHEN clean LIKE '%��h���a%' THEN '��h���a' WHEN clean LIKE '%���AXA%' or clean like '%AXA%' THEN 'AXA' WHEN clean LIKE '%�D�wCarman%' THEN '�D�wCarman'
WHEN clean LIKE '%����%' OR clean LIKE '%����Jason%' THEN '����' WHEN clean LIKE '%RudeHealth%' THEN 'RudeHealth'
WHEN clean LIKE '%Verival%' THEN 'Verival' WHEN clean LIKE '%Seitenbacher%' THEN 'Seitenbacher'
WHEN clean LIKE '%�x�}%' THEN '�x�}' WHEN clean LIKE '%���̦h%' THEN '���̦h' WHEN clean LIKE '%Post%' THEN 'Post'
WHEN clean LIKE '%GRANOLAHOUSE%' THEN 'GRANOLAHOUSE' WHEN clean LIKE '%�֬�%' THEN '�֬�' WHEN clean LIKE '%�충%' THEN '�충' 
WHEN clean LIKE '%�d�֤�%' THEN '�d�֤�' WHEN clean LIKE '%Verival%' THEN 'Verival' WHEN clean LIKE '%�߷纸%' THEN '�߷纸'
WHEN clean LIKE '%���δI%' THEN '���δI' WHEN clean LIKE '%�d�֤�%' THEN '�d�֤�' WHEN clean LIKE '%�j�Y%' THEN '�j�Y����'
WHEN clean LIKE '%�G�դO%' THEN '�G�դO' WHEN clean LIKE '%�충%' THEN '�충' WHEN clean LIKE '%�֭}%' THEN '�֭}'
WHEN clean LIKE '%OCAK%' THEN 'OCAK' WHEN clean LIKE '%����q%' THEN '����q' WHEN clean LIKE '%Bodygoals%' THEN 'Bodygoals'
WHEN clean LIKE '%DailyBoost%' THEN 'DailyBoost' WHEN clean LIKE '%�����թ�%' THEN '�����թ�'
WHEN CHARINDEX('[', clean) > 0 AND CHARINDEX(']', clean) > CHARINDEX('[', clean) THEN SUBSTRING(clean, CHARINDEX('[', clean) + 1, CHARINDEX(']', clean) - CHARINDEX('[', clean) -1)
WHEN CHARINDEX('�i', clean) > 0 AND CHARINDEX('�j', clean) > CHARINDEX('�i', clean) THEN SUBSTRING(clean, CHARINDEX('�i', clean) + 1, CHARINDEX('�j', clean) - CHARINDEX('�i', clean) -1)
WHEN CHARINDEX('�m', clean) > 0 AND CHARINDEX('�n', clean) > CHARINDEX('�m', clean) THEN SUBSTRING(clean, CHARINDEX('�m', clean) + 1, CHARINDEX('�n', clean) - CHARINDEX('�m', clean) -1)
WHEN PATINDEX('%[^a-zA-Z]%', clean) > 1 THEN SUBSTRING(clean, 1, PATINDEX('%[^a-zA-Z]%', clean) - 1)
ELSE null END as brand, 

CASE 
WHEN clean LIKE '%���u%'or clean like '%�q��%' or clean like '%���_%' or clean LIKE '%�q��%' or clean LIKE '%�ۮ�%' or clean LIKE '%�a�֤�%' 
or clean LIKE '%��M%' or clean LIKE '%��h���a%' or clean LIKE '%���AXA%' or clean like '%AXA%' or clean LIKE '%����%' OR clean LIKE '%����Jason%' or clean LIKE '%�D�wCarman%' 
or clean LIKE '%RudeHealth%' or clean LIKE '%Seitenbacher%' or clean LIKE '%�x�}%' or clean LIKE '%���̦h%' or clean LIKE '%Post%' 
or clean LIKE '%GRANOLAHOUSE%' or clean LIKE '%�֬�%' or clean LIKE '%Verival%' or clean LIKE '%�d�֤�%' or clean LIKE '%�߷纸%'
or clean LIKE '%�j�Y%' or clean LIKE '%�G�դO%' or clean LIKE '%�충%' or clean LIKE '%�֭}%' or clean LIKE '%���δI%' or clean LIKE '%OCAK%' 
or clean LIKE '%����q%' or clean LIKE '%Bodygoals%' or clean LIKE '%DailyBoost%' or clean LIKE '%�����թ�%' THEN 1
ELSE 0 END AS isMatched
from practice.dbo.invoice
where (clean like '%�ܤ�%' or clean like '%����%' or clean like '%�\��%' ) and 
(clean not like '%��%' and clean not like '%��%' and clean not like '%��%' and clean not like '%�}��%' and clean not like '%�M%')
GROUP BY totals, clean
)



select clean as name, totals, 
CASE
WHEN isMatched = 1 THEN brand
WHEN CHARINDEX('[', clean) > 0 AND CHARINDEX(']', clean) > CHARINDEX('[', clean) THEN SUBSTRING(clean, CHARINDEX('[', clean) + 1, CHARINDEX(']', clean) - CHARINDEX('[', clean) - 1)
WHEN CHARINDEX('�i', clean) > 0 AND CHARINDEX('�j', clean) > CHARINDEX('�i', clean) THEN SUBSTRING(clean, CHARINDEX('�i', clean) + 1, CHARINDEX('�j', clean) - CHARINDEX('�i', clean) -1)
WHEN CHARINDEX('�m', clean) > 0 AND CHARINDEX('�n', clean) > CHARINDEX('�m', clean) THEN SUBSTRING(clean, CHARINDEX('�m', clean) + 1, CHARINDEX('�n', clean) - CHARINDEX('�m', clean) -1)
WHEN PATINDEX('%[^a-zA-Z]%', clean) > 1 THEN SUBSTRING(clean, 1, PATINDEX('%[^a-zA-Z]%', clean) - 1)
ELSE null END AS brand
from cte
where brand is not null
order by brand, totals DESC



--select *
--from cte