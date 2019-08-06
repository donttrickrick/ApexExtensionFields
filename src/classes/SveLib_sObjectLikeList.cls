/**
 * Copyright 2017 Rick Yang donttrickrick@github.com
 *
 * Redistribution and use in source and binary forms, with or without modification, 
 * are permitted provided that the following conditions are met:
 * 
 * 1. Redistributions of source code must retain the above copyright notice, 
 *    this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice, 
 *    this list of conditions and the following disclaimer in the documentation 
 *    and/or other materials provided with the distribution.
 *
 * 3. Neither the name of the copyright holder nor the names of its contributors 
 *    may be used to endorse or promote products derived from this software without 
 *    specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND 
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, 
 * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. 
 * IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, 
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, 
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) 
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, 
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, 
 * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
public without sharing class SveLib_sObjectLikeList {
    @AuraEnabled
    public final List<SveLib_sObjectLike> l { get; private set; }
    public final List<sObject> original { get; private set; }
    
    public SveLib_sObjectLikeList(List<sObject> sObjLst) {
        l = new List<SveLib_sObjectLike>();
        original = sObjLst;
        for(sObject sObj : sObjLst) {
            SveLib_sObjectLike sObjLike = new SveLib_sObjectLike(sObj);
            sObjLike.setScope(this);
            l.add(sObjLike);
        }
    }
    
    public SveLib_sObjectLikeList(List<SveLib_sObjectLike> sObjLst) {
        l = sObjLst;
        original = this.toSObjectList();
    }
    
    public List<Map<String, Object>> toAuraEnabled() {
        List<Map<String, Object>> lst = new List<Map<String, Object>>();
        for(SveLib_sObjectLike sObjLike : l) {
            lst.add(sObjLike.toAuraEnabled());
        }
        return lst;
    }

    public List<sObject> toSObjectList() {
        List<sObject> lst = new List<sObject>();
        for(SveLib_sObjectLike sObjLike : l) {
            lst.add(sObjLike.toSObject());
        }
        return lst;
    }
    
    public SveLib_sObjectLike first() {
        return count() > 0 ? l[0] : SveLib_sObjectLike.Empty;
    }
    
    public SveLib_sObjectLike last() {
        return count() > 0 ? l[count() - 1] : SveLib_sObjectLike.Empty;
    }

    public List<Object> selectAny(String field) {
        List<Object> objLst = new List<Object>();
        for(SveLib_sObjectLike sobj : l) {
            objLst.add(sobj.getValue(field));
        }
        return objLst;
    }

    public List<String> selectString(String field) {
        List<String> objLst = new List<String>();
        for(SveLib_sObjectLike sObj : l) {
            objLst.add(sObj.getValue(field).toString());
        }
        return objLst;
    }

    public List<Id> selectId(String field) {
        List<Id> idLst = new List<Id>();
        for(SveLib_sObjectLike sobj : l) {
            idLst.add((Id)sobj.getValue(field).value);
        }
        return idLst;
    }
    
    public SveLib_sObjectLikeList selectSObject(String field) {
        List<SveLib_sObjectLike> sObjLst = new List<SveLib_sObjectLike>();
        for(SveLib_sObjectLike sObjLike : l) {
            sObjLst.add(sObjLike.getSObject(field));
        }
        return new SveLib_sObjectLikeList(sObjLst);
    }

    public SveLib_sObjectLikeList selectSObjects(String field) {
        List<SveLib_sObjectLike> sObjLst = new List<SveLib_sObjectLike>();
        for(SveLib_sObjectLike sObjLike : l) {
            sObjLst.addAll(sObjLike.getSObjects(field).l);
        }
        return new SveLib_sObjectLikeList(sObjLst);
    }
    
    public SveLib_sObjectLikeList whereNot(String field, Object predictedValue) {
        List<SveLib_sObjectLike> whereLst = new List<SveLib_sObjectLike>();
        for(SveLib_sObjectLike sObjLike : l) {
            if(!sObjLike.getValue(field).equals(predictedValue)) {
                whereLst.add(sObjLike);
            }
        }
        return new SveLib_sObjectLikeList(whereLst);
    }
    
    public SveLib_sObjectLikeList whereNotIn(String field, List<Object> predictedValueLst) {
        List<SveLib_sObjectLike> whereLst = new List<SveLib_sObjectLike>();
        for(SveLib_sObjectLike sObjLike : l) {
            Boolean isIn = false;
            for(Object predictedValue : predictedValueLst) {
                if(sObjLike.getValue(field).equals(predictedValue)) {
                    isIn = true;
                    break;
                }
            }
            if(!isIn) {
                whereLst.add(sObjLike);
            }
        }
        return new SveLib_sObjectLikeList(whereLst);
    }
    
    public SveLib_sObjectLikeList whereEql(String field, Object predictedValue) {
        List<SveLib_sObjectLike> whereLst = new List<SveLib_sObjectLike>();
        for(SveLib_sObjectLike sObjLike : l) {
            if(sObjLike.getValue(field).equals(predictedValue)) {
                whereLst.add(sObjLike);
            }
        }
        return new SveLib_sObjectLikeList(whereLst);
    }
    
    public SveLib_sObjectLikeList whereIn(String field, List<Object> predictedValueLst) {
        List<SveLib_sObjectLike> whereLst = new List<SveLib_sObjectLike>();
        for(SveLib_sObjectLike sObjLike : l) {
            Boolean isIn = false;
            for(Object predictedValue : predictedValueLst) {
                if(sObjLike.getValue(field).equals(predictedValue)) {
                    isIn = true;
                    break;
                }
            }
            if(isIn) {
                whereLst.add(sObjLike);
            }
        }
        return new SveLib_sObjectLikeList(whereLst);
    }

    public Map<String, SveLib_sObjectLikeList> groupBy(String field) {
        Map<String, List<SveLib_sObjectLike>> sObjectMap = new Map<String, List<SveLib_sObjectLike>>();
        for(SveLib_sObjectLike sObj : l) {
            List<SveLib_sObjectLike> sObjLst = null;
            String key = sObj.getValue(field).toString();
            if(sObjectMap.containsKey(key)) {
                sObjLst = sObjectMap.get(key);
            } else {
                sObjLst = new List<SveLib_sObjectLike>();
                sObjectMap.put(key, sObjLst);
            }
            sObjLst.add(sObj);
        }
        Map<String, SveLib_sObjectLikeList> sObjectLikeMap = new Map<String, SveLib_sObjectLikeList>();
        for(String key : sObjectMap.keySet()) {
            sObjectLikeMap.put(key, new SveLib_sObjectLikeList(sObjectMap.get(key)));
        }
        return sObjectLikeMap;
    }

    public SveLib_sObjectLikeList groupByThenGet(String groupByField, String key) {
        SveLib_sObjectLikeList lst = new SveLib_sObjectLikeList(new List<SveLib_sObjectLike>());
        Map<String, SveLib_sObjectLikeList> sObjMap = groupBy(groupByField);
        if(sObjMap.containsKey(key)) {
            lst = sObjMap.get(key);
        }
        return lst;
    }
    
    // join without compare
    public SveLib_sObjectLikeList concat(SveLib_sObjectLikeList another) {
        List<SveLib_sObjectLike> lst = new List<SveLib_sObjectLike>();
        for(SveLib_sObjectLike sObj : this.l) {
            lst.add(sObj);
        }
        for(SveLib_sObjectLike sObj : another.l) {
            lst.add(sObj);
        }
        return new SveLib_sObjectLikeList(lst);
    }
    // join with compare
    /*
    public SveLib_sObjectLikeList union(SveLib_sObjectLikeList another) {
        List<sObject> newLst = new List<sObject>();
        newLst.addAll(this.original);
        newLst.addAll(another.original);
        return new SveLib_sObjectLikeList(newLst);
    }
    public SveLib_sObjectLikeList except(SveLib_sObjectLikeList another) {
        List<sObject> newLst = new List<sObject>();
        newLst.addAll(this.original);
        newLst.addAll(another.original);
        return new SveLib_sObjectLikeList(newLst);
    }
    public SveLib_sObjectLikeList intersect(SveLib_sObjectLikeList another) {
        List<sObject> newLst = new List<sObject>();
        newLst.addAll(this.original);
        newLst.addAll(another.original);
        return new SveLib_sObjectLikeList(newLst);
    }
    */
    public SveLib_sObjectLikeList distinct(String field) {
        List<SveLib_sObjectLike> cloned = l.clone(); // shallow clone
        for(Integer i = 0; i < cloned.size(); i++) {
            for(Integer j = i + 1; j < cloned.size(); j++) {
                if(cloned[i].getValue(field).equals(cloned[j].getValue(field))) {
                    cloned.remove(j);
                    j--;
                }
            }
        }
        List<SveLib_sObjectLike> lst = new List<SveLib_sObjectLike>();
        for(SveLib_sObjectLike sObj : cloned) {
            lst.add(sObj);
        }
        return new SveLib_sObjectLikeList(lst);
    }
    
    public SveLib_sObjectLikeList orderBy(String field) {
        List<SveLib_Primitives.Value> valueLst = new List<SveLib_Primitives.Value>();
        Map<SveLib_Primitives.Value, List<SveLib_sObjectLike>> valueMap = new Map<SveLib_Primitives.Value, List<SveLib_sObjectLike>>();
        for(SveLib_sObjectLike sObj : l) {
           SveLib_Primitives.Value v = sObj.getValue(field);
           List<SveLib_sObjectLike> subSObjLst = null;
           if(valueMap.containsKey(v)) {
               subSObjLst = valueMap.get(v);
           } else {
               subSObjLst = new List<SveLib_sObjectLike>();
               valueLst.add(v);
               valueMap.put(v, subSObjLst);
           }
           subSObjLst.add(sObj);
       }
       valueLst.sort();
       List<SveLib_sObjectLike> lst = new List<SveLib_sObjectLike>();
       for(SveLib_Primitives.Value v : valueLst) {
           lst.addAll(valueMap.get(v));
       }
       return new SveLib_sObjectLikeList(lst);
    }
    
    public SveLib_sObjectLikeList orderByDESC(String field) {
        return orderBy(field).reverse();
    }
    
    public Boolean one(String field, List<Object> predictedValueLst) {
        Boolean ret = false;
        for(SveLib_sObjectLike sObj : l) {
            for(Object predictedValue : predictedValueLst) {
                ret |= sObj.equals(predictedValue);
            }
            if(ret) {
                break;
            }
        }
        return ret;
    }
    
    public Boolean all(String field, List<Object> predictedValueLst) {
        Boolean ret = null;
        for(SveLib_sObjectLike sObj : l) {
            for(Object predictedValue : predictedValueLst) {
                ret = ret == null ? sObj.equals(predictedValue) : ret & sObj.equals(predictedValue);
            }
            if(!ret) {
                break;
            }
        }
        return ret;
    }

    public Boolean one(String field, Object predictedValue) {
        Boolean ret = false;
        for(SveLib_sObjectLike sObj : l) {
            if(sObj.equals(predictedValue)) {
                ret = true;
                break;
            }
        }
        return ret;
    }
    
    public Boolean all(String field, Object predictedValue) {
        Boolean ret = null;
        for(SveLib_sObjectLike sObj : l) {
            ret = ret == null ? sObj.equals(predictedValue) : ret & sObj.equals(predictedValue);
            if(!ret) {
                break;
            }
        }
        return ret;
    }
    
    public Boolean isEmpty() {
        return count() == 0;
    }
    
    public Boolean isSingle() {
        return count() == 1;
    }
    
    public SveLib_sObjectLikeList reverse() {
        List<SveLib_sObjectLike> reversed = new List<SveLib_sObjectLike>();
        for(Integer i = l.size() - 1; i >= 0; i--) {
            reversed.add(l[i]);
        }
        return new SveLib_sObjectLikeList(reversed);
    }
    
    public SveLib_sObjectLikeList take(Integer size) {
        List<SveLib_sObjectLike> lst = new List<SveLib_sObjectLike>();
        for(Integer i = 0; i < size && i < l.size(); i++) {
            lst.add(l[i]);
        }
        return new SveLib_sObjectLikeList(lst);
    }

    public Object sum(String field) {
        SveLib_Primitives.Value ret = new SveLib_Primitives.ObjectValue(null);
        for(SveLib_sObjectLike sObj : l) {
            ret = ret.value == null ? sObj.getValue(field) : ret.add(sObj.getValue(field));
        }
        return ret;
    }
    public Integer count() {
        return l.size();
    }
    public Object average(String field) {
        SveLib_Primitives.Value ret = new SveLib_Primitives.ObjectValue(null);
        for(SveLib_sObjectLike sObj : l) {
            ret = ret.value == null ? sObj.getValue(field) : ret.add(sObj.getValue(field));
        }
        System.assert(count() != 0, 'average: List size is 0. Cannot calculate average.');
        ret = ret.divide(new SveLib_Primitives.IntegerValue(count()));
        return ret.value;
    }
    public Object max(String field) {
        SveLib_Primitives.Value ret = new SveLib_Primitives.ObjectValue(null);
        for(SveLib_sObjectLike sObj : l) {
            ret = ret.value == null || sObj.getValue(field).greaterThan(ret) ? sObj.getValue(field) : ret;
        }
        return ret;
    }
    public Object min(String field) {
        SveLib_Primitives.Value ret = new SveLib_Primitives.ObjectValue(null);
        for(SveLib_sObjectLike sObj : l) {
            ret = ret.value == null || sObj.getValue(field).lessThan(ret) ? sObj.getValue(field) : ret;
        }
        return ret;
    }
    // Todo
    public Object aggregate(String field) {
        SveLib_Primitives.Value ret = new SveLib_Primitives.ObjectValue(null);
        for(SveLib_sObjectLike sObj : l) {
            ret = ret.value == null || sObj.getValue(field).lessThan(ret) ? sObj.getValue(field) : ret;
        }
        return ret;
    }
    // public SveLib_sObjectLikeList doAction(ILikeActionInvokable action, Map<String, Object> params) {
    //    for(SveLib_sObjectLike sObj : l) {
    //         action.invoke(sObj, params);
    //     }
    //     return this;
    // }
    
    // public SveLib_sObjectLikeList doBulkAction(ILikeListActionInvokable action, Map<String, Object> params) {
    //     action.invoke(this, params);
    //     return this;
    // }
}