create or replace package body pkg_query is
  procedure P_DataPagination(p_tblName   nvarchar2, --表名
                             p_pageSize  in number, --每页大小
                             p_pageIndex in number, --数据页数，从1开始
                             p_strWhere  nvarchar2, --where条件
                             p_OrderBy   nvarchar2, --排序字段
                             p_rowsCnt   out number, --总记录数
                             p_pageCnt   out integer, --总页数
                             p_v_cur     out cur_query) is

    strSql varchar2(2000); --获取数据的sql语句
    --pageCount  number; --该条件下记录页数
    startIndex number; --开始记录
    endIndex   number; --结束记录


    --Page to get the data

  begin
    strSql := 'select count(1) from ' || p_tblName;
    if p_strWhere is not null and length(p_strWhere) > 0 then
      strSql := strSql || ' where ' || p_strWhere;
    end if;
    --DBMS_OUTPUT.put_line(strSql);
    EXECUTE IMMEDIATE strSql
      INTO p_rowsCnt;
    --计算数据记录开始和结束
    if mod(p_rowsCnt, p_pagesize) = 0 then
      p_pageCnt := p_rowsCnt / p_pageSize;
    else
      p_pageCnt := p_rowsCnt / p_pageSize + 1;
    end if;
    --pageCount := p_rowsCnt / p_pageSize + 1;
    --DBMS_OUTPUT.put_line('总记录数:' || p_rowsCnt || '--总页数:' || p_pageCnt);
    startIndex := (p_pageIndex - 1) * p_pageSize + 1;
    endIndex   := p_pageIndex * p_pageSize;
    --通过rownum分页起始页
    strSql := 'select rownum ro, qq.* from ' || p_tblName || ' qq';
    strSql := strSql || ' where rownum<=' || endIndex;
    --添加条件
    if p_strWhere is not null and length(p_strWhere) > 0 then
      strSql := strSql || ' and ' || p_strWhere;
    end if;
    --添加排序
    if p_OrderBy is not null and length(p_OrderBy) > 0 then
      DBMS_OUTPUT.put_line('进入判断了');
      strSql := strSql || ' order by ' || p_OrderBy;
    end if;
    --通过rownum分页结束页
    strSql := 'select * from (' || strSql || ') where ro >=' || startIndex;
    --DBMS_OUTPUT.put_line(strSql);
    --DBMS_OUTPUT.put_line(p_OrderBy);
    --获取数据装入游标返回
    OPEN p_v_cur FOR strSql;
  end P_DataPagination;
end pkg_query;
