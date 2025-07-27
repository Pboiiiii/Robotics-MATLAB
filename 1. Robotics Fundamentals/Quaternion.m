classdef Quaternion
    % Represents a quaternion as a 1×4 vector [w, x, y, z], used for 3D
    % rotation. Supports some quaternion operations like addition,
    % subtraction, multiplication, conjugation and norma.

    properties
        Value (1,4)
    end
    
    % Checking if vector is a valid quaternion representation
    methods
        function obj = Quaternion(v)
            if nargin == 0
                obj.Value = [1 0 0 0];
            elseif isvector(v) && lenght(v) == 4
                obj.Value = v;
            else
                error("Quaternion must be a 1x4 vector")
            end
        end
        
        % Quaternion sumation operation (+)
        function result = plus(q1, q2)
            result = Quaternion(q1.Value + q2.Value);
        end

        % Quaternion subtraction operation (-)
        function result = minus(q1, q2)
            result = Quaternion(q1.Value - q2.Value);
        end
        
        % Quaternion conjugation operation (Q_star)
        function result = conjugate(q)
            s = q.Value(1);
            v = q.Value(2:4);
            result = Quaternion([s v]);
        end
        
        % Quaternion norma operation (||Q||)
        function result = norma(q)
            result = sqrt(q.Value(1)^2 + q.Value(2)^2 + q.Value(3)^2 ...
                + q.Value(4)^2);
        end

        % Quaternion multiplication operation (*)
        function result = mtimes(a, b)
            if isa(a, 'Quaternion') && isa(b, 'Quaternion')
                q30 = a.Value(1)*b.Value(1) - (a.Value(2)*b.Value(2) + ...
                    a.Value(3)*b.Value(3) + a.Value(4)*b.Value(4));
    
                q31 = a.Value(1)*b.Value(2) + a.Value(2)*b.Value(1) + ...
                    a.Value(3)*b.Value(4) - a.Value(4)*b.Value(3);
    
                q32 = a.Value(1)*b.Value(3) + a.Value(3)*b.Value(1) + ...
                    a.Value(4)*b.Value(2) - a.Value(2)*b.Value(4);
    
                q33 = a.Value(1)*b.Value(4) + a.Value(4)*b.Value(1) + ...
                    a.Value(2)*b.Value(3) - a.Value(3)*b.Value(2);
    
                result = Quaternion([q30 q31 q32 q33]);

            elseif isa(a, 'Quaternion') && isnumeric(b)
                result = Quaternion(a.Value * b);

            elseif isa(b, 'Quaternion') && isnumeric(a)
                result = Quaternion(b.Value * a);
                
            else
                error('Unsupported multiplication types.');
            end
        end
    end
end
