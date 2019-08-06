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
public without sharing class SveLib_sObjectLike {
    @AuraEnabled
    public Map<String, Object> objMap { protected set; get; }
    private sObject s { get; private set; }

    public static final SveLib_sObjectLike Empty = new SveLib_sObjectLike(null);
    
    private SveLib_sObjectLikeList scope;
    
    public SveLib_sObjectLike(sObject sObj) {
        if(sObj == null) {
            return;
        }
        s = sObj;
        objMap = new Map<String, Object>(sObj.getPopulatedFieldsAsMap());
    }

    public SveLib_sObjectLike(sObject sObj, SveLib_sObjectLikeList sp) {
        if(sObj == null) {
            return;
        }
        s = sObj;
        objMap = new Map<String, Object>(sObj.getPopulatedFieldsAsMap());
        scope = sp;
    }      
    
    public void setScope(SveLib_sObjectLikeList sp) {
        this.scope = sp;
    }
    
    public void putSetting(String key, Object value) {
        objMap.put(key, value);
    }
    
    public void putSetting(Map<String, Object> keyValues) {
        objMap.putAll(keyValues);
    }
    
    public Map<String, Object> toAuraEnabled() {
        return objMap;
    }

    public sObject toSObject() {
        return s;
    }

    public SveLib_Primitives.Value getValue(String field) {
        return toValue(getField(field));
    }
    
    public Object get(String field) {
        return getField(field);
    }
    
    private List<sObject> getChildRelationshipField(String field) {
        List<sObject> objLst = new List<sObject>();

        if(objMap.containsKey(field)) {
            objLst = (List<sObject>)objMap.get(field);
        } else {
            Object ret = getnPutExtensionField(field, 'ChildRelationship');
            objLst = ret == null ? objLst : (List<sObject>)ret;
        }

        return objLst;
    }

    public SveLib_sObjectLikeList getSObjects(String field) {
        List<sObject> parentLst = getChildRelationshipField(field);
        SveLib_sObjectLikeList sp = selectSObjects(field);
        List<SveLib_sObjectLike> lst = new List<SveLib_sObjectLike>();
        for(sObject parent : parentLst) {
            lst.add(new SveLib_sObjectLike(parent, sp));
        }
        return new SveLib_sObjectLikeList(lst);
    }

    private sObject getParentField(String field) {
        sObject sobj = null;

        String[] pathArray = field.split('[.]');

        if(isValidExtensionParentField('', pathArray[0])) {
            if(objMap.containsKey(pathArray[0])) {
                sobj = (sObject)getDrillDownFieldFromExisting(pathArray[0], 1, pathArray, false);
            } else {
                sObject ret = (sObject)getnPutExtensionField(pathArray[0], 'Parent');
                sobj = ret != null ? getParentField(field) : sobj;
            }
        } else if(pathArray.size() > 1 && isValidExtensionParentField(pathArray[0], pathArray[1])) {
                if(objMap.containsKey(pathArray[0] + '.' + pathArray[1])) {
                sobj = (sObject)getDrillDownFieldFromExisting(pathArray[0] + '.' + pathArray[1], 2, pathArray, false);
            } else {
                sObject ret = (sObject)getnPutExtensionField(pathArray[0] + '.' + pathArray[1], 'Parent');
                sobj = ret != null ? getParentField(field) : sobj;
            }
        } else {
            sobj = (sObject)getDrillDownFieldFromExisting(pathArray[0], 1, pathArray, false);
        }

        return sobj;
    }

    public SveLib_sObjectLike getSObject(String field) {
        return new SveLib_sObjectLike(getParentField(field), selectSObject(field));
    }

    private SveLib_sObjectLikeList selectSObject(String field) {
        List<sObject> sObjLst = new List<sObject>();
        for(SveLib_sObjectLike sObj : scope.l) {
            sObjLst.add(sObj.getParentField(field));
        }
        return new SveLib_sObjectLikeList(sObjLst).distinct('Id');
    }

    private SveLib_sObjectLikeList selectSObjects(String field) {
        List<sObject> sObjLst = new List<sObject>();
        for(SveLib_sObjectLike sObj : scope.l) {
            sObjLst.addAll(sObj.getChildRelationshipField(field));
        }
        return new SveLib_sObjectLikeList(sObjLst).distinct('Id');
    }

    private SveLib_Primitives.Value toValue(Object value) {
        SveLib_Primitives.Value ret = null;
        
        if(value instanceOf Integer) {
            ret = new SveLib_Primitives.IntegerValue(value);
        } else if(value instanceOf String) {
            ret = new SveLib_Primitives.StringValue(value);
        } else if(value instanceOf Id) {
            ret = new SveLib_Primitives.IdValue(value);
        } else if(value instanceOf Double) {
            ret = new SveLib_Primitives.DoubleValue(value);
        } else if(value instanceOf Decimal) {
            ret = new SveLib_Primitives.DecimalValue(value);
        } else if(value instanceOf Boolean) {
            ret = new SveLib_Primitives.BooleanValue(value);
        } else if(value instanceOf Long) {
            ret = new SveLib_Primitives.LongValue(value);
        } else if(value instanceOf Time) {
            ret = new SveLib_Primitives.TimeValue(value);
        } else if(value instanceOf Date) {
            ret = new SveLib_Primitives.DateValue(value);
        } else if(value instanceOf DateTime) {
            ret = new SveLib_Primitives.DateTimeValue(value);
        } else if(value instanceOf Blob) {
            ret = new SveLib_Primitives.BlobValue(value);
        } else {
            ret = new SveLib_Primitives.ObjectValue(value);
        }
        
        return ret;
    }
    
    private Object getnPutExtensionField(String field, String extensionType) {
        Object fieldValue = null;
        
        String namespace = '';
        String clsName = '';
        
        String[] fieldName = field.split('[.]');
        namespace = fieldName.size() > 1 ? fieldName[0] : namespace;
        clsName = fieldName.size() > 1 ? fieldName[1] : fieldName[0];
        
        Type fieldClass = System.Type.forName(namespace, clsName);
        if(fieldClass != null) {
            Object classInstance = fieldClass.newInstance();
            if(extensionType == 'Formula') {
                fieldValue = classInstance instanceOf SveLib_ExtensionFields.FormulaField ? ((SveLib_ExtensionFields.FormulaField)classInstance).get(this) : fieldValue;
            } else if(extensionType == 'Parent') { 
                SveLib_ExtensionFields.QueryResult qr = classInstance instanceOf SveLib_ExtensionFields.Parent ? ((SveLib_ExtensionFields.Parent)classInstance).get(this, scope != null ? scope : new SveLib_sObjectLikeList(new List<sObject>{ this.s })) : new SveLib_ExtensionFields.QueryResult();
                fieldValue = (sObject)qr.result;
            } else if(extensionType == 'ChildRelationship') {
                SveLib_ExtensionFields.QueryResult qr = classInstance instanceOf SveLib_ExtensionFields.ChildRelationship ? ((SveLib_ExtensionFields.ChildRelationship)classInstance).get(this, scope != null ? scope : new SveLib_sObjectLikeList(new List<sObject>{ this.s })) : new SveLib_ExtensionFields.QueryResult();
                fieldValue = (List<sObject>)qr.result;
            }
            objMap.put(field, fieldValue);
        }
        
        return fieldValue;
    }
    
    private Object getDrillDownFieldFromExisting(String existingSObjectName, Integer drillDownStartIndex, String[] drillDownArray, Boolean notQueryParentRelationship) {
        Object ret = null;
        if(objMap.get(existingSObjectName) instanceOf sObject) {
            ret = objMap.get(existingSObjectName);
            for(Integer i = drillDownStartIndex; i < drillDownArray.size(); i++) {
                if(notQueryParentRelationship && i == drillDownArray.size() - 1) {
                    ret = ((sObject)ret).get(drillDownArray[i]);
                } else {
                    ret = ((sObject)ret).getSObject(drillDownArray[i]);
                }
            }
        }
        return ret;
    }
    
    private Boolean isValidExtensionParentField(String namespace, String clsName) {
        Type t = System.Type.forName(namespace, clsName);
        return t != null && t.newInstance() instanceOf SveLib_ExtensionFields.Parent;
    }
    
    private Boolean isValidExtensionFormulaField(String namespace, String clsName) {
        Type t = System.Type.forName(namespace, clsName);
        return t != null && t.newInstance() instanceOf SveLib_ExtensionFields.FormulaField;
    }
    
    private Object getField(String field) {
        Object obj = null;
        String[] pathArray = field.split('[.]');
        
        if(objMap.containsKey(field)) {
            obj = objMap.get(field);
        } else {
            if(isValidExtensionParentField('', pathArray[0])) {
                if(objMap.containsKey(pathArray[0])) {
                    obj = getDrillDownFieldFromExisting(pathArray[0], 1, pathArray, true);
                } else {
                    Object ret = getnPutExtensionField(pathArray[0], 'Parent');
                    obj = ret != null ? get(field) : obj;
                }
            } else if(pathArray.size() > 2 && isValidExtensionParentField(pathArray[0], pathArray[1])) {
                if(objMap.containsKey(pathArray[0] + '.' + pathArray[1])) {
                    obj = getDrillDownFieldFromExisting(pathArray[0] + '.' + pathArray[1], 2, pathArray, true);
                } else {
                    Object ret = getnPutExtensionField(pathArray[0] + '.' + pathArray[1], 'Parent');
                    obj = ret != null ? get(field) : obj;
                }
            } else if((pathArray.size() == 1 && isValidExtensionFormulaField('', pathArray[0]))
                     || (pathArray.size() == 2 && isValidExtensionFormulaField(pathArray[0], pathArray[1]))) {
                if(objMap.containsKey(field)) {
                    obj = get(field);
                } else {
                    Object ret = getnPutExtensionField(field, 'Formula');
                    obj = ret != null ? get(field) : obj;
                }
            } else {
                obj = getDrillDownFieldFromExisting(pathArray[0], 1, pathArray, true);
            }
        }
        
        return obj;
    }
}