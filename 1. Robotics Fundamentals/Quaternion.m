classdef Quaternion
    % Constructs a quaternion, a 1×4 vector [w, x, y, z], used for 3D
    % rotation and translation. Supports some quaternion operations.

    properties
        Vector (1, 4)
    end
    
    methods
        % Constructor: supports either direct 1x4 quaternion or axis-angle (k, theta)
        function obj = Quaternion(v, theta)
            if nargin == 0
                % Default: identity quaternion
                obj.Vector = [1 0 0 0];

            elseif nargin == 1
                % Case 1: input is a 1x4 quaternion
                if isvector(v) && length(v) == 4
                    obj.Vector = v;
                else
                    error("Quaternion must be a 1x4 vector")
                end

            elseif nargin == 2
                % Case 2: input is (k, theta)
                k = v; % axis
                if ~isvector(k) || length(k) ~= 3
                    error("Axis k must be a 1x3 vector")
                end

                w = cos(theta/2);
                xyz = k * sin(theta/2);
                obj.Vector = [w xyz];

            end
        end

        % Quaternion sumation operation (+)
        function result = plus(q1, q2)
            result = Quaternion(q1.Vector + q2.Vector);
        end

        % Quaternion subtraction operation (-)
        function result = minus(q1, q2)
            result = Quaternion(q1.Vector - q2.Vector);
        end
        
        % Quaternion conjugation operation (Q_star)
        function result = conjugate(q)
            s = q.Vector(1);
            v = -q.Vector(2:4);
            result = Quaternion([s v]);
        end
        
        % Quaternion norma operation (||Q||)
        function result = norma(q)
            result = sqrt(q.Vector(1)^2 + q.Vector(2)^2 + q.Vector(3)^2 ...
                + q.Vector(4)^2);
        end

        % Quaternion multiplication operation (*)
        function result = mtimes(a, b)
            if isa(a, 'Quaternion') && isa(b, 'Quaternion')
                q30 = a.Vector(1)*b.Vector(1) - (a.Vector(2)*b.Vector(2) + ...
                    a.Vector(3)*b.Vector(3) + a.Vector(4)*b.Vector(4));
    
                q31 = a.Vector(1)*b.Vector(2) + a.Vector(2)*b.Vector(1) + ...
                    a.Vector(3)*b.Vector(4) - a.Vector(4)*b.Vector(3);
    
                q32 = a.Vector(1)*b.Vector(3) + a.Vector(3)*b.Vector(1) + ...
                    a.Vector(4)*b.Vector(2) - a.Vector(2)*b.Vector(4);
    
                q33 = a.Vector(1)*b.Vector(4) + a.Vector(4)*b.Vector(1) + ...
                    a.Vector(2)*b.Vector(3) - a.Vector(3)*b.Vector(2);
    
                result = Quaternion([q30 q31 q32 q33]);

            elseif isa(a, 'Quaternion') && isnumeric(b)
                result = Quaternion(a.Vector * b);

            elseif isa(b, 'Quaternion') && isnumeric(a)
                result = Quaternion(b.Vector * a);
                
            else
                error('Unsupported multiplication types.');
            end
        end

    end
end