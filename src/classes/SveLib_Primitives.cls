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
 **/
public without sharing abstract class SveLib_Primitives {
    public enum Type {
        BLOBVALUE,
        BOOLEANVALUE,
        DATEVALUE,
        DATETIMEVALUE,
        DECIMALVALUE,
        DOUBLEVALUE,
        IDVALUE,
        INTEGERVALUE,
        LONGVALUE,
        OBJECTVALUE,
        STRINGVALUE,
        TIMEVALUE,
        FUNCTIONVALUE
    }
    
    public abstract class Value implements Comparable, SveLib_IInitializable {
        @AuraEnabled
        public Object value { get; protected set; }
        public SveLib_Primitives.Type type { get; private set; }

        public Value(Object val) {
            value = val;
        }
        public Value(Value v) {
            value = v.value;
        }

        // The method, toString(), need override key word which isnot needed for a common method. 
        public override String toString() {
            return String.valueOf(value);
        }
        public Integer compareTo(Object compareTo) {
            Value compareVal = (Value)compareTo; 
            return this.lessThan(compareVal) ? -1 : (this.greaterThan(compareVal) ? 1 : 0);
        }
        
        public abstract Boolean isEmpty();
        public abstract Boolean equals(Value compareTo);
        public abstract Boolean greaterThan(Value compareTo);
        public abstract Boolean lessThan(Value compareTo);
        public abstract Boolean equals(Object compareTo);
        public abstract Boolean greaterThan(Object compareTo);
        public abstract Boolean lessThan(Object compareTo);
        
        // init
        public virtual Object init(Map<String, Object> params) {
            value = params.get('value');
            return this;
        }
        
        public virtual Value add(Value v) {
            System.assert(false, 'Value: invalid fucntion.');
            return null; 
        }
        public virtual Value sub(Value v) {
            System.assert(false, 'Value: invalid fucntion.');
            return null; 
        }
        public virtual Value multiply(Value v) {
            System.assert(false, 'Value: invalid fucntion.');
            return null; 
        }
        public virtual Value divide(Value v) {
            System.assert(false, 'Value: invalid fucntion.');
            return null; 
        }
    }

    public class TimeValue extends Value {
        public TimeValue(Object val) {
            super(val);
            type = SveLib_Primitives.Type.TIMEVALUE;
        }
        public TimeValue(Object val, Object defaultValue) {
            super(val);
            if(isEmpty()) {
                super(defaultValue);
            }
            type = SveLib_Primitives.Type.TIMEVALUE;
        }
        public override Boolean isEmpty() {
            return value == null;
        }
        public override Boolean equals(Value compareTo) {
            return (Time)this.value == (Time)compareTo.value;
        }
        public override Boolean greaterThan(Value compareTo) {
            return (Time)this.value > (Time)compareTo.value;
        }
        public override Boolean lessThan(Value compareTo) {
            return (Time)this.value < (Time)compareTo.value;
        }
        public override Boolean equals(Object compareTo) {
            return compareTo instanceOf Value ? equals((Value)compareTo) : (Time)this.value == (Time)compareTo;
        }
        public override Boolean greaterThan(Object compareTo) {
            return compareTo instanceOf Value ? greaterThan((Value)compareTo) : (Time)this.value > (Time)compareTo;
        }
        public override Boolean lessThan(Object compareTo) {
            return compareTo instanceOf Value ? lessThan((Value)compareTo) : (Time)this.value < (Time)compareTo;
        }
    }

    public class DateValue extends Value {
        public DateValue(Object val) {
            super(val);
            type = SveLib_Primitives.Type.DATEVALUE;
        }
        public DateValue(Object val, Object defaultValue) {
            super(val);
            if(isEmpty()) {
                super(defaultValue);
            }
            type = SveLib_Primitives.Type.TIMEVALUE;
        }
        public override Boolean isEmpty() {
            return value == null;
        }
        public override Boolean equals(Value compareTo) {
            return (Date)this.value == (Date)compareTo.value;
        }
        public override Boolean greaterThan(Value compareTo) {
            return (Date)this.value > (Date)compareTo.value;
        }
        public override Boolean lessThan(Value compareTo) {
            return (Date)this.value < (Date)compareTo.value;
        }
        public override Boolean equals(Object compareTo) {
            return compareTo instanceOf Value ? equals((Value)compareTo) : (Date)this.value == (Date)compareTo;
        }
        public override Boolean greaterThan(Object compareTo) {
            return compareTo instanceOf Value ? greaterThan((Value)compareTo) : (Date)this.value > (Date)compareTo;
        }
        public override Boolean lessThan(Object compareTo) {
            return compareTo instanceOf Value ? lessThan((Value)compareTo) : (Date)this.value < (Date)compareTo;
        }
    }

    public class DatetimeValue extends Value {
        public DatetimeValue(Object val) {
            super(val);
            type = SveLib_Primitives.Type.DATETIMEVALUE;
        }
        public DatetimeValue(Object val, Object defaultValue) {
            super(val);
            if(isEmpty()) {
                super(defaultValue);
            }
            type = SveLib_Primitives.Type.TIMEVALUE;
        }
        public override Boolean isEmpty() {
            return value == null;
        }
        public override Boolean equals(Value compareTo) {
            return (Datetime)this.value == (Datetime)compareTo.value;
        }
        public override Boolean greaterThan(Value compareTo) {
            return (Datetime)this.value > (Datetime)compareTo.value;
        }
        public override Boolean lessThan(Value compareTo) {
            return (Datetime)this.value < (Datetime)compareTo.value;
        }
        public override Boolean equals(Object compareTo) {
            return compareTo instanceOf Value ? equals((Value)compareTo) : (Datetime)this.value == (Datetime)compareTo;
        }
        public override Boolean greaterThan(Object compareTo) {
            return compareTo instanceOf Value ? greaterThan((Value)compareTo) : (Datetime)this.value > (Datetime)compareTo;
        }
        public override Boolean lessThan(Object compareTo) {
            return compareTo instanceOf Value ? lessThan((Value)compareTo) : (Datetime)this.value < (Datetime)compareTo;
        }
    }

    public class DecimalValue extends Value {
        public DecimalValue(Object val) {
            super(val);
            type = SveLib_Primitives.Type.DECIMALVALUE;
        }
        public DecimalValue(Object val, Object defaultValue) {
            super(val);
            if(isEmpty()) {
                super(defaultValue);
            }
            type = SveLib_Primitives.Type.TIMEVALUE;
        }
        public override Boolean isEmpty() {
            return value == null;
        }
        public override Boolean equals(Value compareTo) {
            return (Decimal)this.value == (Decimal)compareTo.value;
        }
        public override Boolean greaterThan(Value compareTo) {
            return (Decimal)this.value > (Decimal)compareTo.value;
        }
        public override Boolean lessThan(Value compareTo) {
            return (Decimal)this.value < (Decimal)compareTo.value;
        }
        public override Boolean equals(Object compareTo) {
            return compareTo instanceOf Value ? equals((Value)compareTo) : (Decimal)this.value == (Decimal)compareTo;
        }
        public override Boolean greaterThan(Object compareTo) {
            return compareTo instanceOf Value ? greaterThan((Value)compareTo) : (Decimal)this.value > (Decimal)compareTo;
        }
        public override Boolean lessThan(Object compareTo) {
            return compareTo instanceOf Value ? lessThan((Value)compareTo) : (Decimal)this.value < (Decimal)compareTo;
        }
        public override Value add(Value v) {
            return new DecimalValue((Decimal)this.value + (Decimal)v.value); 
        }
        public override Value sub(Value v) {
            return new DecimalValue((Decimal)this.value - (Decimal)v.value);
        }
        public override Value multiply(Value v) {
            return new DecimalValue((Decimal)this.value * (Decimal)v.value);
        }
        public override Value divide(Value v) {
            return new DecimalValue((Decimal)this.value / (Decimal)v.value);
        }
    }

    public class DoubleValue extends Value {
        public DoubleValue(Object val) {
            super(val);
            type = SveLib_Primitives.Type.DOUBLEVALUE;
        }
        public DoubleValue(Object val, Object defaultValue) {
            super(val);
            if(isEmpty()) {
                super(defaultValue);
            }
            type = SveLib_Primitives.Type.TIMEVALUE;
        }
        public override Boolean isEmpty() {
            return value == null;
        }
        public override Boolean equals(Value compareTo) {
            return (Double)this.value == (Double)compareTo.value;
        }
        public override Boolean greaterThan(Value compareTo) {
            return (Double)this.value > (Double)compareTo.value;
        }
        public override Boolean lessThan(Value compareTo) {
            return (Double)this.value < (Double)compareTo.value;
        }
        public override Boolean equals(Object compareTo) {
            return compareTo instanceOf Value ? equals((Value)compareTo) : (Double)this.value == (Double)compareTo;
        }
        public override Boolean greaterThan(Object compareTo) {
            return compareTo instanceOf Value ? greaterThan((Value)compareTo) : (Double)this.value > (Double)compareTo;
        }
        public override Boolean lessThan(Object compareTo) {
            return compareTo instanceOf Value ? lessThan((Value)compareTo) : (Double)this.value < (Double)compareTo;
        }
        public override Value add(Value v) {
            return new DoubleValue((Double)this.value + (Double)v.value); 
        }
        public override Value sub(Value v) {
            return new DoubleValue((Double)this.value - (Double)v.value);
        }
        public override Value multiply(Value v) {
            return new DoubleValue((Double)this.value * (Double)v.value);
        }
        public override Value divide(Value v) {
            return new DoubleValue((Double)this.value / (Double)v.value);
        }
    }

    public class IntegerValue extends Value {
        public IntegerValue(Object val) {
            super(val);
            type = SveLib_Primitives.Type.INTEGERVALUE;
        }
        public IntegerValue(Object val, Object defaultValue) {
            super(val);
            if(isEmpty()) {
                super(defaultValue);
            }
            type = SveLib_Primitives.Type.TIMEVALUE;
        }
        public override Boolean isEmpty() {
            return value == null;
        }
        public override Boolean equals(Value compareTo) {
            return (Integer)this.value == (Integer)compareTo.value;
        }
        public override Boolean greaterThan(Value compareTo) {
            return (Integer)this.value > (Integer)compareTo.value;
        }
        public override Boolean lessThan(Value compareTo) {
            return (Integer)this.value < (Integer)compareTo.value;
        }
        public override Boolean equals(Object compareTo) {
            return compareTo instanceOf Value ? equals((Value)compareTo) : (Integer)this.value == (Integer)compareTo;
        }
        public override Boolean greaterThan(Object compareTo) {
            return compareTo instanceOf Value ? greaterThan((Value)compareTo) : (Integer)this.value > (Integer)compareTo;
        }
        public override Boolean lessThan(Object compareTo) {
            return compareTo instanceOf Value ? lessThan((Value)compareTo) : (Integer)this.value < (Integer)compareTo;
        }
        public override Value add(Value v) {
            return new IntegerValue((Integer)this.value + (Integer)v.value); 
        }
        public override Value sub(Value v) {
            return new IntegerValue((Integer)this.value - (Integer)v.value);
        }
        public override Value multiply(Value v) {
            return new IntegerValue((Integer)this.value * (Integer)v.value);
        }
        public override Value divide(Value v) {
            return new IntegerValue((Integer)this.value / (Integer)v.value);
        }
    }

    public class StringValue extends Value {
        public StringValue(Object val) {
            super(val);
            type = SveLib_Primitives.Type.STRINGVALUE;
        }
        public StringValue(Object val, Object defaultValue) {
            super(val);
            if(isEmpty()) {
                super(defaultValue);
            }
            type = SveLib_Primitives.Type.TIMEVALUE;
        }
        public override Boolean isEmpty() {
            return String.isEmpty((String)value);
        }
        public override Boolean equals(Value compareTo) {
            return (String)this.value == (String)compareTo.value;
        }
        public override Boolean greaterThan(Value compareTo) {
            return (String)this.value > (String)compareTo.value;
        }
        public override Boolean lessThan(Value compareTo) {
            return (String)this.value < (String)compareTo.value;
        }
        public override Boolean equals(Object compareTo) {
            return compareTo instanceOf Value ? equals((Value)compareTo) : (String)this.value == (String)compareTo;
        }
        public override Boolean greaterThan(Object compareTo) {
            return compareTo instanceOf Value ? greaterThan((Value)compareTo) : (String)this.value > (String)compareTo;
        }
        public override Boolean lessThan(Object compareTo) {
            return compareTo instanceOf Value ? lessThan((Value)compareTo) : (String)this.value < (String)compareTo;
        }
    }

    public class BooleanValue extends Value {
        public BooleanValue(Object val) {
            super(val);
            type = SveLib_Primitives.Type.BOOLEANVALUE;
        }
        public BooleanValue(Object val, Object defaultValue) {
            super(val);
            if(isEmpty()) {
                super(defaultValue);
            }
            type = SveLib_Primitives.Type.TIMEVALUE;
        }
        public override Boolean isEmpty() {
            return value == null;
        }
        public override Boolean equals(Value compareTo) {
            return (Boolean)this.value == (Boolean)compareTo.value;
        }
        public override Boolean greaterThan(Value compareTo) {
            return false;
        }
        public override Boolean lessThan(Value compareTo) {
            return false;
        }
        public override Boolean equals(Object compareTo) {
            return compareTo instanceOf Value ? equals((Value)compareTo) : (Boolean)this.value == (Boolean)compareTo;
        }
        public override Boolean greaterThan(Object compareTo) {
            return false;
        }
        public override Boolean lessThan(Object compareTo) {
            return false;
        }
    }

    public class LongValue extends Value {
        public LongValue(Object val) {
            super(val);
            type = SveLib_Primitives.Type.LONGVALUE;
        }
        public LongValue(Object val, Object defaultValue) {
            super(val);
            if(isEmpty()) {
                super(defaultValue);
            }
            type = SveLib_Primitives.Type.TIMEVALUE;
        }
        public override Boolean isEmpty() {
            return value == null;
        }
        public override Boolean equals(Value compareTo) {
            return (Long)this.value == (Long)compareTo.value;
        }
        public override Boolean greaterThan(Value compareTo) {
            return (Long)this.value > (Long)compareTo.value;
        }
        public override Boolean lessThan(Value compareTo) {
            return (Long)this.value > (Long)compareTo.value;
        }
        public override Boolean equals(Object compareTo) {
            return compareTo instanceOf Value ? equals((Value)compareTo) : (Long)this.value == (Long)compareTo;
        }
        public override Boolean greaterThan(Object compareTo) {
            return compareTo instanceOf Value ? greaterThan((Value)compareTo) : (Long)this.value > (Long)compareTo;
        }
        public override Boolean lessThan(Object compareTo) {
            return compareTo instanceOf Value ? lessThan((Value)compareTo) : (Long)this.value > (Long)compareTo;
        }
        public override Value add(Value v) {
            return new LongValue((Long)this.value + (Long)v.value); 
        }
        public override Value sub(Value v) {
            return new LongValue((Long)this.value - (Long)v.value);
        }
        public override Value multiply(Value v) {
            return new LongValue((Long)this.value * (Long)v.value);
        }
        public override Value divide(Value v) {
            return new LongValue((Long)this.value / (Long)v.value);
        }
    }

    public class IdValue extends Value {
        public IdValue(Object val) {
            super(val);
            type = SveLib_Primitives.Type.IDVALUE;
        }
        public IdValue(Object val, Object defaultValue) {
            super(val);
            if(isEmpty()) {
                super(defaultValue);
            }
            type = SveLib_Primitives.Type.TIMEVALUE;
        }
        public override Boolean isEmpty() {
            return value == null || value == '';
        }
        public override Boolean equals(Value compareTo) {
            return (ID)this.value == (ID)compareTo.value;
        }
        public override Boolean greaterThan(Value compareTo) {
            return (ID)this.value > (ID)compareTo.value;
        }
        public override Boolean lessThan(Value compareTo) {
            return (ID)this.value > (ID)compareTo.value;
        }
        public override Boolean equals(Object compareTo) {
            return compareTo instanceOf Value ? equals((Value)compareTo) : (ID)this.value == (ID)compareTo;
        }
        public override Boolean greaterThan(Object compareTo) {
            return compareTo instanceOf Value ? greaterThan((Value)compareTo) : (ID)this.value > (ID)compareTo;
        }
        public override Boolean lessThan(Object compareTo) {
            return compareTo instanceOf Value ? lessThan((Value)compareTo) : (ID)this.value > (ID)compareTo;
        }
        
    }
    
    public class BlobValue extends Value implements SveLib_IInitializable {    
        public BlobValue(Object val) {
            super(val);
            type = SveLib_Primitives.Type.BLOBVALUE;
        }
        public BlobValue(Object val, Object defaultValue) {
            super(val);
            if(isEmpty()) {
                super(defaultValue);
            }
            type = SveLib_Primitives.Type.BLOBVALUE;
        }
        
        public override Boolean isEmpty() {
            return value == null;
        }
        public override Boolean equals(Value compareTo) {
            return (Blob)this.value == (Blob)compareTo.value;
        }
        public override Boolean greaterThan(Value compareTo) {
            System.assert(false, 'BlobValue: invalid fucntion.');
            return false;
        }
        public override Boolean lessThan(Value compareTo) {
            System.assert(false, 'BlobValue: invalid fucntion.');
            return false;
        }
        public override Boolean equals(Object compareTo) {
            return compareTo instanceOf Value ? equals((Value)compareTo) : (Blob)this.value == (Blob)compareTo;
        }
        public override Boolean greaterThan(Object compareTo) {
            System.assert(false, 'BlobValue: invalid fucntion.');
            return false;
        }
        public override Boolean lessThan(Object compareTo) {
            System.assert(false, 'BlobValue: invalid fucntion.');
            return false;
        }
    }
    
    public class ObjectValue extends Value implements SveLib_IInitializable {        
        public ObjectValue(Object val) {
            super(val);
            type = SveLib_Primitives.Type.OBJECTVALUE;
        }
        
        public override Boolean isEmpty() {
            return this.value == null;
        }
        public override Boolean equals(Value compareTo) {
            return compareTo.value == this.value;
        }
        public override Boolean greaterThan(Value compareTo) {
            System.assert(false, 'ObjectValue: invalid fucntion.');
            return null;
        }
        public override Boolean lessThan(Value compareTo) {
            System.assert(false, 'ObjectValue: invalid fucntion.');
            return null;
        }
        public override Boolean equals(Object compareTo) {
            return compareTo instanceOf Value ? equals((Value)compareTo) : compareTo == this.value;
        }
        public override Boolean greaterThan(Object compareTo) {
            System.assert(false, 'ObjectValue: invalid fucntion.');
            return null;
        }
        public override Boolean lessThan(Object compareTo) {
            System.assert(false, 'ObjectValue: invalid fucntion.');
            return null;
        }
    }
    
}