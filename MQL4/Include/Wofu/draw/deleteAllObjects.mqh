enum ENUM_DELETE_OBJECT_MODE
{
  DELETE_OBJECT_BY_PREFIX=0,
  DELETE_OBJECT_BY_FIND=1,
  DELETE_OBJECT_ALL=999,
   

};
void deleteAllObjects(ENUM_DELETE_OBJECT_MODE fmode,string fFindString="")  export
{  int i=0;
   switch(fmode)
   {
      case 0:
        //找開頭
        ObjectsDeleteAll(0,fFindString);
        //for(i=ObjectsTotal()-1;i>=0;i--)if(StringFind(ObjectName(i),fFindString)==0 )ObjectDelete(ObjectName(i));
        break;
      case 1:
        //有找到
        for(i=ObjectsTotal()-1;i>=0;i--)if(StringFind(ObjectName(i),fFindString)>=0 )ObjectDelete(ObjectName(i));
        break;
      case 999:
        //全刪
        for(i=ObjectsTotal()-1;i>=0;i--)ObjectDelete(ObjectName(i));
        break;
      default:
        //預設找開頭
        for(i=ObjectsTotal()-1;i>=0;i--)if(StringFind(ObjectName(i),fFindString)>=0 )ObjectDelete(ObjectName(i));
        break;
   }
}
