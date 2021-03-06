class ClassOrdersTradesInfo
  {
   public:
      //void setNew( string text,string url);
      ClassOrdersTradesInfo();
      void getInfo(string fSymbol,int fMagicNumber);
      int countBuy;
      int countBuystop;
      int countBuyLimit;
      int countSell;
      int countSellstop;
      int countSellLimit;

      int countAll;
      int countOpen;
      int countStop;
      int countLimit;
      int countPre;                 //預掛單
      int countPreBuy;             
      int countPreSell;
      
      double openLotsBuy;
      double openLotsSell;
      double openAvgCostBuy;        //平均BUY 價
      double openAvgCostSell;       //平均SELL價
      double openAvgCost;           //平均成本

      double profitBuy;             //BUY 營利
      double profitSell;            //SELL營利
      double profitAll;             //全部營利

      
   private:
      

   protected: 
      string sysCode;
      string eaCode;
      string objId;  
      double openPriceLotsBuy;    
      double openPriceLotsSell;
   //---- 
  };


ClassOrdersTradesInfo::ClassOrdersTradesInfo()
{
};

void ClassOrdersTradesInfo::getInfo(string fSymbol,int fMagicNumber)
{
   this.countBuy=0;
   this.countBuystop=0;
   this.countBuyLimit=0;
   this.countSell=0;
   this.countSellstop=0;
   this.countSellLimit=0;
   
   this.openLotsBuy=0;
   this.openLotsSell=0;
   this.openAvgCostBuy=0;
   this.openAvgCostSell=0;
   this.openAvgCost=0;
   this.openPriceLotsBuy=0;
   this.openPriceLotsSell=0;

   this.profitBuy =0;             //BUY 營利
   this.profitSell=0;             //SELL營利
   this.profitAll =0;             //全部營利

     for(int i=0;i<OrdersTotal();i++)
     {
         if( OrderSelect(i,SELECT_BY_POS,MODE_TRADES) && 
             ( fSymbol=="ALL"   || OrderSymbol()==fSymbol ) && 
             ( fMagicNumber==-1 || OrderMagicNumber()==fMagicNumber ) )
         { 
            switch(OrderType())
            {
               case ORDER_TYPE_BUY:
                  this.countBuy++;
                  this.openLotsBuy+=OrderLots();
                  this.openPriceLotsBuy+=OrderOpenPrice()*OrderLots();
                  this.profitBuy+=OrderProfit() + OrderCommission() + OrderSwap();
                  break;
               case ORDER_TYPE_SELL:
                  this.countSell++;
                  this.openLotsSell+=OrderLots();
                  this.openPriceLotsSell+=OrderOpenPrice()*OrderLots();
                  this.profitSell+=OrderProfit() + OrderCommission() + OrderSwap();
                  break;
               case ORDER_TYPE_BUY_STOP:
                  this.countBuystop++;
                  break;
               case ORDER_TYPE_SELL_STOP:
                  this.countSellstop++;
                  break;
               case ORDER_TYPE_BUY_LIMIT:
                  this.countBuyLimit++;
                  break;
               case ORDER_TYPE_SELL_LIMIT:
                  this.countSellLimit++;
                  break;               
               default:
                  break;
            }      
         }
      }
      this.countOpen =this.countBuy+this.countSell;
      this.countStop =this.countBuystop+this.countSellstop;
      this.countLimit=this.countBuyLimit+this.countSellLimit;
      
      this.countPre=this.countStop+this.countLimit;
      this.countPreBuy=this.countBuystop+this.countBuyLimit;
      this.countPreSell=this.countSellstop+this.countSellLimit;
      this.countAll=this.countOpen+this.countStop+this.countLimit;
      
      int    SymDigits=(int)SymbolInfoInteger(fSymbol,SYMBOL_DIGITS);
      this.openAvgCostBuy =(this.openLotsBuy>0 )?NormalizeDouble(this.openPriceLotsBuy /this.openLotsBuy ,SymDigits):0;
      this.openAvgCostSell=(this.openLotsSell>0)?NormalizeDouble(this.openPriceLotsSell/this.openLotsSell,SymDigits):0;
      this.openAvgCost=( (this.openLotsBuy+this.openLotsSell)>0 )?NormalizeDouble( (this.openPriceLotsSell+this.openPriceLotsBuy )/(this.openLotsBuy+this.openLotsSell),SymDigits):0;
      this.profitAll=this.profitBuy+this.profitSell;
}
