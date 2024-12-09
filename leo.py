p = '/Users/darcyluo/code/darcyluojt/Christmas challenge/Reboot-01-Christmas-list/data.txt'
with open(p, 'r') as f:
    data = f.readlines()

s = "MAS"
strings = [s, s[::-1]]
m,n = len(data), len(data[0])

count = 0
for i in range(m-2): # i is the row index
    for j in range(n-2): # j is the column index
        if (
            any(
                all(
                    data[i+index][j+index] == character for index,character in enumerate(s)
                )  for s in strings
            )
            and any(
                all(
                    data[i+index][j+2-index] == character for index,character in enumerate(s)
                ) for s in strings
            )
        ):
            count += 1
        # for potential_string in strings:
        #     match = True
        #     for offset, character in enumerate(potential_string): # s is MAS or SAM
        #         if data[i+offset][j+offset] != character:
        #             match = False
        #             break
        #     if match:
        #         for potential_string_2 in strings:
        #             match_2 = True
        #             for offset, character in enumerate(potential_string_2):
        #                 if data[i+offset][j+2-offset] != character:
        #                     match_2 = False
        #                     break
        #             if match_2:
        #                 count += 1
        #         break
print(count)
