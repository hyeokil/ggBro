INSERT INTO `member` (
                       `created_at`
                     ,`updated_at`
                     ,`email`
                     ,`nickname`
                     ,`password`


)
VALUES (
         NOW()
       ,NOW()
       ,'test1@test.com'
       ,'테스트 1'
       ,'ssafy!123'
)
     ,(
        NOW()
      ,NOW()
      ,'test2@test.com'
      ,'테스트 2'
      ,'ssafy!123'
);