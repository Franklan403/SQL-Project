

WITH cte AS (
SELECT clean, sum(totals) as totals, CASE
WHEN clean LIKE '%光泉%' THEN '光泉' WHEN clean LIKE '%義美%' THEN '義美' WHEN clean LIKE '%雀巢%' THEN '雀巢'
WHEN clean LIKE '%桂格%' THEN '桂格' WHEN clean LIKE '%家樂氏%' THEN '家樂氏' WHEN clean LIKE '%日清%' THEN '日清'
WHEN clean LIKE '%瑞士全家%' THEN '瑞士全家' WHEN clean LIKE '%瑞典AXA%' or clean like '%AXA%' THEN 'AXA' WHEN clean LIKE '%澳洲Carman%' THEN '澳洲Carman'
WHEN clean LIKE '%捷森%' OR clean LIKE '%荷蘭Jason%' THEN '捷森' WHEN clean LIKE '%RudeHealth%' THEN 'RudeHealth'
WHEN clean LIKE '%Verival%' THEN 'Verival' WHEN clean LIKE '%Seitenbacher%' THEN 'Seitenbacher'
WHEN clean LIKE '%台糖%' THEN '台糖' WHEN clean LIKE '%巧米多%' THEN '巧米多' WHEN clean LIKE '%Post%' THEN 'Post'
WHEN clean LIKE '%GRANOLAHOUSE%' THEN 'GRANOLAHOUSE' WHEN clean LIKE '%福紅%' THEN '福紅' WHEN clean LIKE '%科隆%' THEN '科隆' 
WHEN clean LIKE '%卡樂比%' THEN '卡樂比' WHEN clean LIKE '%Verival%' THEN 'Verival' WHEN clean LIKE '%喜瑞爾%' THEN '喜瑞爾'
WHEN clean LIKE '%麥佳富%' THEN '麥佳富' WHEN clean LIKE '%卡樂比%' THEN '卡樂比' WHEN clean LIKE '%大頭%' THEN '大頭叔叔'
WHEN clean LIKE '%果諾力%' THEN '果諾力' WHEN clean LIKE '%科隆%' THEN '科隆' WHEN clean LIKE '%福迪%' THEN '福迪'
WHEN clean LIKE '%OCAK%' THEN 'OCAK' WHEN clean LIKE '%金瑞益%' THEN '金瑞益' WHEN clean LIKE '%Bodygoals%' THEN 'Bodygoals'
WHEN clean LIKE '%DailyBoost%' THEN 'DailyBoost' WHEN clean LIKE '%格蘭諾拉%' THEN '格蘭諾拉'
WHEN CHARINDEX('[', clean) > 0 AND CHARINDEX(']', clean) > CHARINDEX('[', clean) THEN SUBSTRING(clean, CHARINDEX('[', clean) + 1, CHARINDEX(']', clean) - CHARINDEX('[', clean) -1)
WHEN CHARINDEX('【', clean) > 0 AND CHARINDEX('】', clean) > CHARINDEX('【', clean) THEN SUBSTRING(clean, CHARINDEX('【', clean) + 1, CHARINDEX('】', clean) - CHARINDEX('【', clean) -1)
WHEN CHARINDEX('《', clean) > 0 AND CHARINDEX('》', clean) > CHARINDEX('《', clean) THEN SUBSTRING(clean, CHARINDEX('《', clean) + 1, CHARINDEX('》', clean) - CHARINDEX('《', clean) -1)
WHEN PATINDEX('%[^a-zA-Z]%', clean) > 1 THEN SUBSTRING(clean, 1, PATINDEX('%[^a-zA-Z]%', clean) - 1)
ELSE null END as brand, 

CASE 
WHEN clean LIKE '%光泉%'or clean like '%義美%' or clean like '%雀巢%' or clean LIKE '%義美%' or clean LIKE '%桂格%' or clean LIKE '%家樂氏%' 
or clean LIKE '%日清%' or clean LIKE '%瑞士全家%' or clean LIKE '%瑞典AXA%' or clean like '%AXA%' or clean LIKE '%捷森%' OR clean LIKE '%荷蘭Jason%' or clean LIKE '%澳洲Carman%' 
or clean LIKE '%RudeHealth%' or clean LIKE '%Seitenbacher%' or clean LIKE '%台糖%' or clean LIKE '%巧米多%' or clean LIKE '%Post%' 
or clean LIKE '%GRANOLAHOUSE%' or clean LIKE '%福紅%' or clean LIKE '%Verival%' or clean LIKE '%卡樂比%' or clean LIKE '%喜瑞爾%'
or clean LIKE '%大頭%' or clean LIKE '%果諾力%' or clean LIKE '%科隆%' or clean LIKE '%福迪%' or clean LIKE '%麥佳富%' or clean LIKE '%OCAK%' 
or clean LIKE '%金瑞益%' or clean LIKE '%Bodygoals%' or clean LIKE '%DailyBoost%' or clean LIKE '%格蘭諾拉%' THEN 1
ELSE 0 END AS isMatched
from practice.dbo.invoice
where (clean like '%脆片%' or clean like '%麥片%' or clean like '%穀物%' ) and 
(clean not like '%棒%' and clean not like '%餅%' and clean not like '%罐%' and clean not like '%飼料%' and clean not like '%杯%')
GROUP BY totals, clean
)



select clean as name, totals, 
CASE
WHEN isMatched = 1 THEN brand
WHEN CHARINDEX('[', clean) > 0 AND CHARINDEX(']', clean) > CHARINDEX('[', clean) THEN SUBSTRING(clean, CHARINDEX('[', clean) + 1, CHARINDEX(']', clean) - CHARINDEX('[', clean) - 1)
WHEN CHARINDEX('【', clean) > 0 AND CHARINDEX('】', clean) > CHARINDEX('【', clean) THEN SUBSTRING(clean, CHARINDEX('【', clean) + 1, CHARINDEX('】', clean) - CHARINDEX('【', clean) -1)
WHEN CHARINDEX('《', clean) > 0 AND CHARINDEX('》', clean) > CHARINDEX('《', clean) THEN SUBSTRING(clean, CHARINDEX('《', clean) + 1, CHARINDEX('》', clean) - CHARINDEX('《', clean) -1)
WHEN PATINDEX('%[^a-zA-Z]%', clean) > 1 THEN SUBSTRING(clean, 1, PATINDEX('%[^a-zA-Z]%', clean) - 1)
ELSE null END AS brand
from cte
where brand is not null
order by brand, totals DESC



--select *
--from cte