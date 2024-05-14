INSERT INTO `member` (
                       `created_at`
                     ,`updated_at`
                     ,`email`
                     ,`nickname`
                     ,`password`
                     ,`is_tutorial`



)
VALUES (
         NOW()
       ,NOW()
       ,'dummy1@dummy.com'
       ,'dummy 1'
       ,'ssafy!123'
       ,true

)
     ,(
        NOW()
      ,NOW()
      ,'dummy2@dummy.com'
      ,'dummy 2'
      ,'ssafy!123'
      ,true
);