SQLquery = """
SELECT 'rentals: %s --> %s' AS FD,
CASE WHEN COUNT(*)=0 THEN 'MAY HOLD'
ELSE 'does not hold' END AS VALIDITY
FROM (
        SELECT r.%s
        FROM rentals r
        GROUP BY r.%s
        HAVING COUNT(DISTINCT r.%s) > 1
) X;
"""

def PrintSQL(Att1, Att2):
    print(SQLquery % (Att1, Att2, Att1, Att1, Att2))

R = ['pid', 'hid', 'pn', 's', 'hs', 'hz', 'hc']
for i in range(len(R)):
    for j in range(len(R)):
        if (i != j):
            PrintSQL(R[i], R[j])

